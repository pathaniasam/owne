

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/response/all_review_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class AllReviewController extends GetxController{
  var userlogin=GetStorage();
  List<AllReviewData> data=[];
  String? id;


  @override
  void onInit() {
    super.onInit();
    callAllReview();
  }

  void callAllReview() {

    AppUtils().checkInternet().then((value){
      if(value){
        ApiHelper.get(NetworkUtils.professionalReviews+id.toString()+"/reviews",authtoken: userlogin.read(GetConstant.token)).then((values) {
          AllReviewResponse response=AllReviewResponse.fromJson(jsonDecode(values.data));
          data.clear();
          data.addAll(response.data!);
          update();
        });
      }else{

      }
    });
  }

}