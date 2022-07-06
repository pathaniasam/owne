

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownervet/drawer/controllers/drawer_controllers.dart';
import 'package:ownervet/model/request/dashboard_request.dart';
import 'package:ownervet/model/response/all_services.dart';
import 'package:ownervet/model/response/dashboard_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:place_picker/entities/location_result.dart';

class SearchController extends GetxController{

  TextEditingController filterController = TextEditingController();
  List<String> filterList = ["Price", "Distance",];
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  LatLng? currentPostion;
  List<HomeData> data=[];
  bool isLoading =true;
  var userlogin=GetStorage();
  List<ServicesData> serviceData=[];
  final List<String> genderItems = [
    'Cat',
    'Dog',
  ];
  final List<String> paymentTypes = [
    'Cash or Credit',
    'Credit Only',
    'Financement',
  ];
  final List<double> ratingTypes = [
   5.0,
    4.0,
    3.0
  ];

  int? categoryIndexs=0;
  int? subCategoryIndexs;

  List<int> ratingList=[];
  String? latitude;
  String? longitude;
  List<LatLng> latLngList = List.empty(growable: true);

  String type="";
  String paymentType="";

  int? selectSlot;
  int? paymentSlot;
  int? ratingIndexs;
  int? ratingValue;
  Set<Marker> markers = Set();
  late BitmapDescriptor restaurantMarker;
    CameraPosition? kGooglePlex;
    String name="";
    String image="";
    String address="";
    String id="";
    bool isshow=false;
  @override
  void onInit() async{
    super.onInit();
    Get.lazyPut<DrawersController>(
          () => DrawersController(),
    );
    restaurantMarker = BitmapDescriptor.fromBytes(await getBytesFromAsset(
        'assets/images/marker.png', //custom marker
        75));
    getAllServices();
    getUserLocation();

  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void callDashBaord(double latitude,double longitude) {

    AppUtils().checkInternet().then((value) {
      if(value){
        isLoading=true;
        update();
        DashbaordRequest request=DashbaordRequest(latitude: "30.71",longitude:"76.72");
        ApiHelper.get(NetworkUtils.dashBoard,params: request.toJson(),authtoken: userlogin.read(GetConstant.token)).then((values) {
          DashboardReponse response=DashboardReponse.fromJson(jsonDecode(values.data));
          if(response!=null){
            //  categories.addAll(response.categories!);
            data.addAll(response.professionals!.data!);
            if(data.length>0){
              kGooglePlex = CameraPosition(
                target: LatLng(data.first.lat!, data.first.lng!),
                zoom: 14.4746,
              );
            }else{
              kGooglePlex = CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              );
            }

            data.forEach((element) {
              markers.add(
                // latlng.isNotEmpty,
                  Marker(
                      markerId: MarkerId(element.id.toString()),
                      position: LatLng(element.lat!,element.lng!),
                      // infoWindow: InfoWindow(
                      //     title: resturants[i].restaurantName ?? '',
                      //     snippet: "go here"),
                      icon: restaurantMarker,
                      onTap: () {
                        id=element.id.toString();
                        name=element.name!;
                        image=element.profileImage!;
                        address=element.address!;
                        isshow=true;

                        update();
                      }));
            });
print("markerslength"+markers.length.toString());
            isLoading=false;
            update();
          }
        });
      }else{

      }
    });
  }
  void getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse){
      var position = await GeolocatorPlatform.instance.getCurrentPosition();
      currentPostion = LatLng(position.latitude, position.longitude);
      callDashBaord(currentPostion!.latitude,currentPostion!.longitude);
    }


  }

  void getAllServices() {
    AppUtils().checkInternet().then((value){
      if(value){
        ApiHelper.get(NetworkUtils.services,).then((values) {
          AllServices response=AllServices.fromJson(jsonDecode(values.data));
          serviceData.addAll(response.data!);
          update();
        });
      }else{

      }
    });

  }

  void selectedIndex(int index) {
    selectSlot=index;
   type= genderItems[index];
   update();
  }
  void paymentIndex(int index) {
    paymentSlot=index;
    paymentType= paymentTypes[index];
    update();
  }

  void ratingIndex(int index) {
    ratingIndexs=index;
    ratingValue= ratingTypes[index].toInt();
    update();
  }

  genderSearch(String name){
    type=name;
    filterApiCall();
  }


  filterApiCall(){
    AppUtils().checkInternet().then((value) {
      if(value){

        DashbaordRequest request =DashbaordRequest(latitude: "30.71", longitude: "76.72",type: type,categoryId: categoryIndexs.toString(),rating: ratingValue,payment:paymentType );
        ApiHelper.get(NetworkUtils.category_filter,authtoken: userlogin.read(GetConstant.token),params: request.toJson()).then((values) {
          DashboardReponse response = DashboardReponse.fromJson(jsonDecode(values.data));
          markers.clear();
          data.clear();
          categoryIndexs=0;
          type="";

          data.addAll(response.professionals!.data!);
          data.forEach((element) {
            markers.add(
              // latlng.isNotEmpty,
                Marker(
                    markerId: MarkerId(element.id.toString()),
                    position: LatLng(element.lat!,element.lng!),
                    // infoWindow: InfoWindow(
                    //     title: resturants[i].restaurantName ?? '',
                    //     snippet: "go here"),
                    icon: restaurantMarker,
                    onTap: () {
                      name=element.name!;
                      image=element.profileImage!;
                      address=element.address!;
                      id=element.id.toString();
                      isshow=true;

                      update();
                    }));
          });
          update();
        });
      }else{

      }
    });
  }
  getAddress(String address, LocationResult result) {
    latLngList.add(result.latLng!);
    latitude = latLngList[0].latitude.toString();
    longitude = latLngList[0].longitude.toString();
    filterApiCalls(latitude!,longitude!);
    update();
  }




  filterApiCalls(String long,String lat){
    AppUtils().checkInternet().then((value) {
      if(value){

        DashbaordRequest request =DashbaordRequest(latitude: long, longitude: lat,);
        ApiHelper.get(NetworkUtils.category_filter,authtoken: userlogin.read(GetConstant.token),params: request.toJson()).then((values) {
          DashboardReponse response = DashboardReponse.fromJson(jsonDecode(values.data));
          markers.clear();
          data.clear();


          data.addAll(response.professionals!.data!);
          data.forEach((element) {
            markers.add(
              // latlng.isNotEmpty,
                Marker(
                    markerId: MarkerId(element.id.toString()),
                    position: LatLng(element.lat!,element.lng!),
                    // infoWindow: InfoWindow(
                    //     title: resturants[i].restaurantName ?? '',
                    //     snippet: "go here"),
                    icon: restaurantMarker,
                    onTap: () {
                      name=element.name!;
                      image=element.profileImage!;
                      address=element.address!;
                      isshow=true;

                      update();
                    }));
          });
          update();
        });
      }else{

      }
    });
  }


  void openDrawer() {

    scaffoldkey.currentState!.openEndDrawer();
  }

  categoryIndex(int index){
    categoryIndexs=index;
    update();
  }
  subIndex(int index){
    subCategoryIndexs=index;
    update();
  }


  filterPrice(String price){
if(price=="Price"){
  priceSort();
}else{

}
  }

  priceSort(){
    data.sort(
            (a, b) => a.price!.toInt().compareTo(b.price!.toInt()));
    update();
  }

  distanceSort(){
    data.sort(
            (a, b) => a.distance!.toInt().compareTo(b.distance!.toInt()));
    update();
  }
}