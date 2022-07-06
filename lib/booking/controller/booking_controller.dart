

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/response/all_appointment_response.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class BookingController extends GetxController{
var userLogin=GetStorage();
GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

List<AllAppointmentData> data=[];
AllAppointmentResponse? response;
  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
var scrollcontroller = ScrollController();

  @override
  void onInit() {
    scrollcontroller.addListener(pagination);

    super.onInit();
    getAllAppointement();
  }

  void getAllAppointement() {
    AppUtils().checkInternet().then((value) {
      if(value){
        ApiHelper.get(NetworkUtils.createAppointment,authtoken: userLogin.read(GetConstant.token)).then((values){
         if(values.statusCode==200){
            response=AllAppointmentResponse.fromJson(jsonDecode(values.data));
           data.clear();
            data.addAll(response!.data!);
           update();
         }else{

         }
        });
      }else{

      }
    });
  }
void pagination() {
  if(response!=null){
    if ((scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent) && (response!.pageInfo!.hasMoreData??false)) {
      AppUtils().checkInternet().then((value){
        if(value){
          update();
          ApiHelper.get(response!.pageInfo!.nextPageUrl!,addBaseUrl:false,authtoken: userLogin.read(GetConstant.token)).then((values) {
            if(values.statusCode==200){
              response=AllAppointmentResponse.fromJson(jsonDecode(values.data));
              //data.clear();
              data.addAll(response!.data!);
              update();
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
void openDrawer() {

  scaffoldkey.currentState!.openDrawer();
}
}