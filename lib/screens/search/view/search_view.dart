

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/screens/search/controller/search_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_alert_dialogue.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

class SearchView extends GetView<SearchController> {
  var greenBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.fillColor),
      borderRadius: BorderRadius.all(Radius.circular(12)));
  var blueBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.fillColor),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init:
        Get.put<SearchController>(SearchController()),
        builder: (controller) {
          //controller.onInit();
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            showPlacePicker(context);
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 15, right: 10, top: 15, bottom: 10),
                              child: CustomTextFieldWidget(
                                enabled: false,
                                fillColor: AppColors.fillColor,

                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                prefixIcon: Icon(CupertinoIcons.location),
                                suffixIcon: Image.asset(
                                  "assets/images/directions.png",
                                ),

                                maxLength: 5,

                                border: greenBorder,

                                hintText: "Enter Location",
                              )),
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 10, top: 15, bottom: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(

                            padding: MaterialStateProperty.all<
                                EdgeInsetsGeometry>(EdgeInsets.all(12.0)),
                            backgroundColor: MaterialStateProperty.resolveWith<
                                Color>((states) {
                              return AppColors.ButtonColor;
                            }),

                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            overlayColor: MaterialStateProperty.resolveWith<
                                Color>((states) {
                              return AppColors.ButtonColor;
                            }),

                            //For text color,
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black),
                            //For border
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return BorderSide(
                                    color: AppColors.ButtonColor,
                                    width: 2,
                                  );
                                else
                                  return BorderSide(
                                      color: AppColors.ButtonColor, width: 2);
                              },
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.searchFilter);
                        //    dialogueShowFilter(context);
                          }, child: Text("List", style: TextStyle(
                            color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  controller.isLoading ? Center(
                    child: CircularProgressIndicator(),) : Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: controller.kGooglePlex!,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: controller.markers,
                        ),
                        if (controller.isshow) Positioned(
                          bottom: 20,
                          left: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: (){
                              DashBoardDetailController response=Get.put<DashBoardDetailController>(DashBoardDetailController());
                             print(controller.id.toString()+"MYId");
                              response.id=controller.id;

                              Get.toNamed(AppRoutes.detail_home);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: controller.image,
                                    height: 120,
                                    width: double.infinity,
                                    progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(controller.name),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(controller.address),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ) else Container()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  dialogueShowFilter(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomAlertPopup(
          name: "Filter Search",
          message: "",
          buttons: [],
          image: '',
          data: controller.serviceData,
        );
      },
    );
  }


  void showPlacePicker(BuildContext context) async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyAMY2WRi3CO4RVgR4eYiQ7nfZf0JqOqBbY",
        )));
    if(result!=null){
      controller.getAddress(result.formattedAddress!,result);
    }

    // Handle the result in your way
    print(result);
  }
}