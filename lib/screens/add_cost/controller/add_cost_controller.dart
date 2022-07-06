import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/add_cost_request.dart';
import 'package:ownervet/model/response/home_detail_response.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class AddCostController extends GetxController{
  TextEditingController priceController =TextEditingController();
  TextEditingController reviewController =TextEditingController();

  List<Services>? servicesList;
  int? professsionalId;
  int? serviceID;
  String currency="";
  var isLoading=false;


  @override
  void onInit() {
    super.onInit();
    if(servicesList!=null){
      if(servicesList!.length!=0){
        currency=servicesList!.first.currency!;

      }
    }

  }

  selectServicId(Services value){
    serviceID=value.id;
    update();
  }

  var userlogin=GetStorage();
  addCost(){
    AppUtils().checkInternet().then((value) {
    if(value){
      if(priceController.text.isEmpty) {
        return;
      }if(serviceID==null) {
       return;
      }
      isLoading=true;
      update();
  AddCostRequest request=AddCostRequest(price: double.parse(priceController.text),professionalId: professsionalId,professionalServiceId: serviceID,currency: currency.isEmpty?"CAD":currency);
  ApiHelper.post(NetworkUtils.customer_quotations,authtoken: userlogin.read(GetConstant.token),body: request.toJson()).then((values) {
    if(values!.statusCode==200){
      LoginResponse response=LoginResponse.fromJson(jsonDecode(values.data));
      AppUtils.Snackbar("Success", response.message);
      isLoading=false;
      Get.offAllNamed(AppRoutes.HOME);
      update();
    }else{
      LoginResponse response=LoginResponse.fromJson(jsonDecode(values.data));
      AppUtils.Snackbar("Success", response.message);
      Get.offAllNamed(AppRoutes.HOME);

      isLoading=false;
      update();
    }
  });

    }else{

    }
    });
  }

}