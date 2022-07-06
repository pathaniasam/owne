

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/add_review.dart';
import 'package:ownervet/model/response/ReviewResponse.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class  ReviewsController extends GetxController{
  var userlogin=GetStorage();
  TextEditingController reviewController=TextEditingController();
  bool isLoading=false;

  String? imageUrl;
  String? name;
  String? id;

  int star=0;



  addReview(){
    AppUtils().checkInternet().then((value){
      if(value){

        if(reviewController.text.isEmpty){
          AppUtils.Snackbar("Review", "Please add review");
          return;

        }else if(star==0){
          AppUtils.Snackbar("Rating", "Please add rating");
          return;
        }
        isLoading=true;
        update();
        ReviewRequest request=ReviewRequest(stars:star,review: reviewController.text );
ApiHelper.post(NetworkUtils.appointments_review+id.toString()+"/"+"reviews",authtoken:userlogin.read(GetConstant.token), body: request.toJson()).then((values) {
  if(values!.statusCode==200){
    AppUtils.Snackbar("Success", "Review submitted successfully");

    Get.offAllNamed(AppRoutes.HOME);
  }else{
    AppUtils.Snackbar("Message", "You have already submitted review for this appointment");

    Get.offAllNamed(AppRoutes.HOME);
  }

});
      }else{
        AppUtils.Snackbar("Connections", "Please check your internet connection");

      }
    });
  }

  setRating(double rating){
    star=rating.toInt();
    update();
  }


}