

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/create_question_request.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class AddQuestionController extends GetxController{

var userlogin=GetStorage();
var isLoading =false;

TextEditingController questionController =TextEditingController();
  void callCreateQuestion(String question) {
    if(questionController.text.isEmpty){
      AppUtils.Snackbar("Add Question", "Please add a question");

      return;
    }

    AppUtils().checkInternet().then((value) {
      if(value){
        isLoading =true;
        update();
        CreateQuestionRequest request =CreateQuestionRequest(question: question);
        ApiHelper.post(NetworkUtils.create_community,body: request.toJson(),authtoken:userlogin.read(GetConstant.token) ).then((values) {
          if(values!.statusCode==201){
            LoginResponse response = LoginResponse.fromJson(jsonDecode(values.data));

            AppUtils.Snackbar("Success", response.message);

            isLoading =false;
            Get.offAllNamed(AppRoutes.HOME);

            update();
          }else{
            LoginResponse response = LoginResponse.fromJson(jsonDecode(values!.data));
            AppUtils.Snackbar("Error", response.message);
            isLoading =false;
            update();
          }
        });
      }else{

      }
    });
  }

}