import 'dart:convert';

import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownervet/drawer/controllers/drawer_controllers.dart';
import 'package:ownervet/model/request/dashboard_request.dart';
import 'package:ownervet/model/response/categories_response.dart';
import 'package:ownervet/model/response/dashboard_response.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/model/response/my_subscription.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/src/managers/call_manager.dart';
import 'package:ownervet/src/managers/push_notifications_manager.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/configs.dart' as utils;
import 'package:ownervet/utils/pref_util.dart';

class DashBoardController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<String> iconList = [
    "assets/images/veterinarian.png",
    "assets/images/pug.png",
    "assets/images/training.png",
    "assets/images/animal_shelter.png",
    "assets/images/boarding.png"
  ];

  List<Categorie> categories = [];
  List<HomeData> data = [];

  bool isLoading = true;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  LatLng? currentPostion;
  var scrollcontroller = ScrollController();

  var userlogin = GetStorage();
  int? selectedIndex;
  int? categoryId;
  DashboardReponse? response;
  Professionals? responses;
  @override
  void onInit() {
    scrollcontroller.addListener(pagination);

    super.onInit();

    Get.lazyPut<DrawersController>(
      () => DrawersController(),
    );
   // logout();

  //  loginConnection();

    getUserLocation();
    getAllCategories();
    getMySubscription();
  }

  loginConnection(){
    if(userlogin.read(GetConstant.id)!=null){
      getUserByLogin("own"+userlogin.read(GetConstant.id).toString())
          .then((cubeUser) {
        CubeUser users=      CubeUser(
          id: cubeUser!.id!,
          login:"own"+ userlogin.read(GetConstant.id).toString(),
          fullName:userlogin.read(GetConstant.name),
          password: "supersecurepwd",
        );
        CubeChatConnection.instance.login(users).then((cubeUser) {
          //Get.offAllNamed(AppRoutes.HOME);
          PushNotificationsManager.instance.init();


        }).catchError((exception) {
          print(exception);
          //   _processLoginError(exception);
        });});
    }

  }

  void openDrawer() {
    scaffoldkey.currentState!.openDrawer();
  }

  void callDashBaord(double latitude, double longitude) {
    AppUtils().checkInternet().then((value) {
      if (value) {
        isLoading = true;
        update();
        DashbaordRequest request =
            DashbaordRequest(latitude: "30.71", longitude: "76.72");
        ApiHelper.get(NetworkUtils.dashBoard,
                params: request.toJson(),
                authtoken: userlogin.read(GetConstant.token))
            .then((values) {
           response =
              DashboardReponse.fromJson(jsonDecode(values.data));
          if (response != null) {
            //  categories.addAll(response.categories!);
            responses=response!.professionals;
            data.clear();
            data.addAll(response!.professionals!.data!);
            isLoading = false;
            update();
          }
        });
      } else {

      }
    });
  }
  void pagination() {
    if(response!=null){
      if ((scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent) && (responses!.pageInfo!.hasMoreData??false)) {
        AppUtils().checkInternet().then((value){
          if(value){
            update();
            ApiHelper.get(responses!.pageInfo!.nextPageUrl!,addBaseUrl:false,authtoken: userlogin.read(GetConstant.token)).then((values) {
              if(values.statusCode==200){
                response =
                    DashboardReponse.fromJson(jsonDecode(values.data));                //data.clear();
                data.addAll(response!.professionals!.data!);
                isLoading = false;
                //   isLoading=false;
                //   update();
              }else{
                LoginResponse response = LoginResponse.fromJson(jsonDecode(values!.data));
                AppUtils.Snackbar("Error", response.message);
                //  isLoading=false;
                update();
              }

            });
          }else{

          }
        });
      }
    }

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
        permission == LocationPermission.whileInUse) {
      var position = await GeolocatorPlatform.instance.getCurrentPosition();
      currentPostion = LatLng(position.latitude, position.longitude);
      callDashBaord(currentPostion!.latitude, currentPostion!.longitude);
    }
  }

  void getAllCategories() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        ApiHelper.get(NetworkUtils.categories).then((values) {
          CategoriesResponse response =
              CategoriesResponse.fromJson(jsonDecode(values.data));
          categories.addAll(response.categories!);
          update();
        });
      } else {}
    });
  }

  void selectedIndexCategory(int index){
    selectedIndex=index;
    categoryId= categories[index].id;
    update();

  }

  callCategoryData(){
    AppUtils().checkInternet().then((value) {
      if(value){
        if(categoryId==null){
          return;
        }
        DashbaordRequest request =DashbaordRequest(latitude: "30.71", longitude: "76.72");
       ApiHelper.get(NetworkUtils.category_filter+categoryId.toString(),authtoken: userlogin.read(GetConstant.token),params: request.toJson()).then((values) {
         DashboardReponse response = DashboardReponse.fromJson(jsonDecode(values.data));
         data.clear();
         data.addAll(response.professionals!.data!);
         update();
       });
      }else{

      }
    });
  }

  callSearchCategoryData(String name){
    AppUtils().checkInternet().then((value) {
      if(value){

        DashbaordRequest request =DashbaordRequest(latitude: "30.71", longitude: "76.72",name: name);
        ApiHelper.get(NetworkUtils.category_filter,authtoken: userlogin.read(GetConstant.token),params: request.toJson()).then((values) {
          DashboardReponse response = DashboardReponse.fromJson(jsonDecode(values.data));
          data.clear();
          data.addAll(response.professionals!.data!);
          update();
        });
      }else{

      }
    });
  }

  void getMySubscription() {
    AppUtils().checkInternet().then((value) {
      if(value){

        ApiHelper.get(NetworkUtils.subscription,authtoken: userlogin.read(GetConstant.token),).then((values) {
          if(values.statusCode==200){
            MySubscription subscription=MySubscription.fromJson(jsonDecode(values.data));
            userlogin.write(GetConstant.Payment,subscription.subscription!.validityEndOn);

          }else{

          }
          update();
        });
      }else{

      }
    });
  }

  void logout() async{
    CallManager.instance.destroy();
    CubeChatConnection.instance.destroy();
    await PushNotificationsManager.instance.unsubscribe();
    await SharedPrefs.deleteUserData();
    await signOut();
  }
}
