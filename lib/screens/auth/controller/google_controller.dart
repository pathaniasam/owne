


import 'dart:convert';
import 'dart:developer';

import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile,FormData;
import 'package:get_storage/get_storage.dart';
import 'package:mime/mime.dart';
import 'package:ownervet/model/request/login_request.dart';
import 'package:ownervet/model/request/social_request.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/social/facebook.dart';
import 'package:ownervet/social/google.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/pref_util.dart';

class GoogleController extends GetxController{
  var userlogin = GetStorage();

  callRegister() async {
  {
    gSignIn().then((value) {
    if(value!=null){
      /*var formData = FormData.fromMap({
      'name': value.displayName,
      'email': value.email,
      'mobile': value.phoneNumber,
      'account_source': "google",

      'image': value.photoURL
      });*/
      SocialRequest request=SocialRequest(name: value.displayName,accountSource:"google",email: value.email,image: value.photoURL);
      ApiHelper.post(NetworkUtils.auth_social,body: request.toJson()).then((value){
        if(value!.statusCode==200){
          LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));
          userlogin.write(GetConstant.name,response.name);
          //userlogin.write(GetConstant.id,response.id);
          userlogin.write(GetConstant.token,response.token);
          //userlogin.write(GetConstant.role,response.role);
          //isLoading=false;
          AppUtils.Snackbar("Success", "You have successfully login");

         //Get.offAllNamed(AppRoutes.HOME);
          loginUsers(response);
          update();
          print("Success");
        }else{
          LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));

          AppUtils.Snackbar("Error", response.message);
        }
      });
    }
    });

  }

}

  callFacebookRegister() async {
    {

      signInWithFacebook().then((value) {
        log(value.user!.toString());
        if(value!=null){

          SocialRequest request=SocialRequest(name: value.user!.displayName,email: value.user!.email,image: value.user!.photoURL,accountSource: "facebook");

          ApiHelper.post(NetworkUtils.auth_social,body: request.toJson()).then((value){
            if(value!.statusCode==200){
              LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));
              userlogin.write(GetConstant.name,response.name);
             userlogin.write(GetConstant.id,response.id);
              userlogin.write(GetConstant.token,response.token);
             userlogin.write(GetConstant.role,response.role);
              //isLoading=false;
              AppUtils.Snackbar("Success", "You have successfully login");
              loginUsers(response);

             // Get.offAllNamed(AppRoutes.HOME);

              update();
              print("Success");
            }else{
              LoginResponse response=LoginResponse.fromJson(jsonDecode(value.data));

              AppUtils.Snackbar("Error", response.message);
            }
          });
        }
      });

    }

  }


  void signupUsers(CubeUser user) {
    signUp(user).then((cubeUser) {
      CubeChatConnection.instance.login(user).then((cubeUser) async {
       // isLoading = false;
        SharedPrefs.saveNewUser(user).then((value) {
          Get.offAllNamed(AppRoutes.HOME);
        }).catchError((error) {
          print("myerror");
        });
      }).catchError((exception) {
        print(exception);
        //   _processLoginError(exception);
      });


    }).catchError((error) {});
  }


  loginUsers(LoginResponse response){
    CubeUser user = CubeUser(
        login:"own"+ response.id.toString(),
        password: 'supersecurepwd',
        email: "",
        fullName:response.name,
        phone: '',
        website: '',
        customData: "'}");


    getUserByLogin("own"+response.id.toString())
        .then((cubeUser) {
      CubeUser users=      CubeUser(
        id: cubeUser!.id!,
        login:"own"+ response.id.toString(),
        fullName:response.name,
        password: "supersecurepwd",
      );
      CubeChatConnection.instance.login(users).then((cubeUser) {
        Get.offAllNamed(AppRoutes.HOME);


      }).catchError((exception) {
        print(exception);
        //   _processLoginError(exception);
      });
    }).catchError((exception) {

      signUp(user)
          .then((cubeUser) {

        signupUsers(user);

      })
          .catchError((error){});
    });
  }

}