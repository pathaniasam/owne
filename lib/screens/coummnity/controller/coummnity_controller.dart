

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/response/coummnity_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class CoummnityController extends GetxController{
  var userlogin= GetStorage();
  CoummnityResponse? coummnityResponse;
  List<CoummnityData> data=[];
  var isLoading=true;
  var scrollcontroller = ScrollController();
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  void openDrawer() {

    scaffoldkey.currentState!.openDrawer();
  }
  @override
  void onInit() {
    scrollcontroller.addListener(pagination);

    super.onInit();
    getAllQuestion();
    
  }

  void pagination() {
    if(coummnityResponse!=null){
      if ((scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent) && (coummnityResponse!.pageInfo!.hasMoreData??false)) {
        AppUtils().checkInternet().then((value){
          if(value){
            update();
            ApiHelper.get(coummnityResponse!.pageInfo!.nextPageUrl!,addBaseUrl:false,authtoken: userlogin.read(GetConstant.token)).then((values) {
              coummnityResponse=CoummnityResponse.fromJson(jsonDecode(values.data));
              data!.addAll(coummnityResponse!.data!);
              isLoading=false;
              update();

            });
          }else{

          }
        });
      }
    }

  }

  void getAllQuestion() {
    AppUtils().checkInternet().then((value){
      if(value){
        isLoading=true;
        update();
        ApiHelper.get(NetworkUtils.community,authtoken: userlogin.read(GetConstant.token)).then((values) {
    coummnityResponse=CoummnityResponse.fromJson(jsonDecode(values.data));
    data.clear();
    data!.addAll(coummnityResponse!.data!);
    isLoading=false;
    update();

        });
      }else{

      }
    });
  }

}