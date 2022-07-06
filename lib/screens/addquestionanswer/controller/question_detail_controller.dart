

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/answer_request.dart';
import 'package:ownervet/model/response/coummnity_response.dart';
import 'package:ownervet/model/response/detail_question_response.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class AddQuestionDetailController extends GetxController{
  var userlogin=GetStorage();
  var isLoading =true;
  int? id;
  TextEditingController replyAnswer=TextEditingController();
  DetailQuestionResponse? response;
  List<DetailQuestionData> data=[];
  CoummnityData? questionData;
  var scrollcontroller = ScrollController();

  @override
  void onInit() {
    scrollcontroller.addListener(pagination);

    super.onInit();
    callDetailQuestion();
  }

  void callDetailQuestion() {

    AppUtils().checkInternet().then((value) {
      if(value){
        ApiHelper.get(NetworkUtils.community_answer+id.toString(),authtoken:userlogin.read(GetConstant.token) ).then((values) {


          if(values.statusCode==200){
            response= DetailQuestionResponse.fromJson(jsonDecode(values.data));
            data.clear();
            data.addAll(response!.data!);
            isLoading=false;
            update();
          }else{
            LoginResponse response = LoginResponse.fromJson(jsonDecode(values.data));
            AppUtils.Snackbar("Error", response.message);
            isLoading=false;
            update();
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
            ApiHelper.get(response!.pageInfo!.nextPageUrl!,addBaseUrl:false,authtoken: userlogin.read(GetConstant.token)).then((values) {
              if(values.statusCode==200){
                response= DetailQuestionResponse.fromJson(jsonDecode(values.data));
                data.addAll(response!.data!);
                isLoading=false;
                update();
              }else{
                LoginResponse response = LoginResponse.fromJson(jsonDecode(values!.data));
                AppUtils.Snackbar("Error", response.message);
                isLoading=false;
                update();
              }

            });
          }else{

          }
        });
      }
    }

  }
  void callReplyAnswer(String answer){
    if(answer.isEmpty){
      AppUtils.Snackbar("Reply Answer", "Please  send a answer");

      return;
    }
    AppUtils().checkInternet().then((value) {
      AnswerRequest request= AnswerRequest(answer:answer);

      ApiHelper.post(NetworkUtils.community_answer+id.toString(),authtoken: userlogin.read(GetConstant.token),body: request.toJson()).then((values) {
        if(values!.statusCode==201){
          LoginResponse response = LoginResponse.fromJson(jsonDecode(values!.data));
          AppUtils.Snackbar("Success", response.message);
          isLoading=false;
          replyAnswer.text="";
          callDetailQuestion();
          update();
        }else{
          LoginResponse response = LoginResponse.fromJson(jsonDecode(values.data));
          AppUtils.Snackbar("Error", response.message);
          isLoading=false;
          update();
        }
      });
    });
  }

  @override
  void dispose() {
    print("Dispose");
  }
}