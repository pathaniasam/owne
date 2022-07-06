

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/response/all_pet_response.dart';
import 'package:ownervet/model/response/my_profile_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class MyProfileController extends GetxController{

  var userlogin=GetStorage();
  bool isLoading =false;
  MyData? myRresponses;
  List<Pets> pets=[];
  @override
  void onInit() {
    super.onInit();
    print("Myprofile");
    callProfileApi();
    callAddPetProfile();
  }
  @override
  void onReady() {

    super.onReady();
    print("ready");
  }

  void callProfileApi() {
    AppUtils().checkInternet().then((values) {
      if(values){
        ApiHelper.get(NetworkUtils.my_profile,authtoken:userlogin.read(GetConstant.token) ).then((value) {
          MyProfileResponse response=MyProfileResponse.fromJson(jsonDecode(value.data));
          myRresponses=response.data!;
          update();

        });
      }else{

      }
    });
  }

  void callAddPetProfile() {
    AppUtils().checkInternet().then((values) {
      if(values){
        ApiHelper.get(NetworkUtils.add_pet,authtoken:userlogin.read(GetConstant.token) ).then((value) {
          AllPetResponse response=AllPetResponse.fromJson(jsonDecode(value.data));
          if(response.pets!=null){
            pets.addAll(response.pets!);
            update();
          }


        });
      }else{
        AppUtils.Snackbar("Connection", "Please check your internet connection");

      }
    });
  }

}