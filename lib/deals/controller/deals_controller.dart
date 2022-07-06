import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/dashboard_request.dart';
import 'package:ownervet/model/response/all_deals_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class DealsController extends GetxController {
  var userLogin = GetStorage();
  List<AllDealsData> data = [];
  TextEditingController filterController = TextEditingController();
  List<String> filterList = ["All", "Cheap", "Expensive"];
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    getAllDeals();
  }

  void getAllDeals() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        DashbaordRequest request =
            DashbaordRequest(latitude: "30.71", longitude: "76.72");

        ApiHelper.get(
          NetworkUtils.deals,
          params: request.toJson(),
          authtoken: userLogin.read(GetConstant.token),
        ).then((values) {
          AllDealsResponse response =
              AllDealsResponse.fromJson(jsonDecode(values.data));
          data.clear();
          data.addAll(response.data!);
          update();
        });
      } else {}
    });
  }

void  filtersList(String name){
    if(name=="Cheap"){
      data.sort(
              (a, b) => a.discount!.toDouble().compareTo(b.discount!.toDouble()));
      update();
    }else if(name=="Expensive"){
      data.sort(
              (a, b) => b.discount!.toDouble().compareTo(a.discount!.toDouble()));
      update();

    }else if(name=="All"){
      getAllDeals();
    }
  }

  void openDrawer() {

    scaffoldkey.currentState!.openDrawer();
  }
}
