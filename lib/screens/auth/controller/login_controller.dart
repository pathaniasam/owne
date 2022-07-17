import 'dart:convert';

import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

class LoginController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool isLoading = false;
  var userlogin = GetStorage();

  callLoginApi() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      isLoading = true;
      update();
      print("Email" + nameController.text);
      print("Email" + passwordController.text);
      LoginRequest request = LoginRequest(
          accountSource: "manual",
          email: nameController.text,
          password: passwordController.text);
      ApiHelper.post(NetworkUtils.login_api, body: request.toJson())
          .then((value) {
        if (value!.statusCode == 200) {
          LoginResponse response =
              LoginResponse.fromJson(jsonDecode(value.data));
          userlogin.write(GetConstant.name, response.name);
          userlogin.write(GetConstant.id, response.id);
          userlogin.write(GetConstant.token, response.token);
          userlogin.write(GetConstant.role, response.role);
          userlogin.write(GetConstant.image, response.profile_image);
          isLoading = false;

          loginUsers(response);

          AppUtils.Snackbar("Success", "You have successfully login");
        } else {
          LoginResponse response =
              LoginResponse.fromJson(jsonDecode(value.data));

          AppUtils.Snackbar("Error", response.message);

          isLoading = false;

          update();
        }
      }).onError((error, stackTrace) {
        isLoading = false;

        AppUtils.Snackbar("Error", error.toString());
        update();
      });
    }
  }

  callRegister() async {
    {
      gSignIn().then((value) {
        if (value != null) {
          SocialRequest request = SocialRequest(
              name: value.displayName,
              accountSource: "google",
              email: value.email,
              image: value.photoURL);
          ApiHelper.post(NetworkUtils.auth_social, body: request.toJson())
              .then((value) {
            if (value!.statusCode == 200) {
              LoginResponse response =
                  LoginResponse.fromJson(jsonDecode(value.data));
              userlogin.write(GetConstant.name, response.name);
              //userlogin.write(GetConstant.id,response.id);
              userlogin.write(GetConstant.token, response.token);
              //userlogin.write(GetConstant.role,response.role);
              //isLoading=false;
              AppUtils.Snackbar("Success", "You have successfully login");

              Get.offAllNamed(AppRoutes.HOME);
              loginUsers(response);

              update();
              print("Success");
            } else {
              LoginResponse response =
                  LoginResponse.fromJson(jsonDecode(value.data));

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
        if (value != null) {
          SocialRequest request = SocialRequest(
              name: value.user!.displayName,
              email: value.user!.email,
              image: value.user!.photoURL,
              accountSource: "facebook");

          ApiHelper.post(NetworkUtils.auth_social, body: request.toJson())
              .then((value) {
            if (value!.statusCode == 200) {
              LoginResponse response =
                  LoginResponse.fromJson(jsonDecode(value.data));
              userlogin.write(GetConstant.name, response.name);
              userlogin.write(GetConstant.id, response.id);
              userlogin.write(GetConstant.token, response.token);
              userlogin.write(GetConstant.role, response.role);
              //isLoading=false;
              AppUtils.Snackbar("Success", "You have successfully login");

              Get.offAllNamed(AppRoutes.HOME);
              loginUsers(response);

              update();
              print("Success");
            } else {
              LoginResponse response =
                  LoginResponse.fromJson(jsonDecode(value.data));

              AppUtils.Snackbar("Error", response.message);
            }
          });
        }
      });
    }
  }

  showPasswords(bool showPasswords) {
    showPassword = !showPasswords;
    update();
  }

  void signupUsers(CubeUser user) {
    signUp(user).then((cubeUser) {
      CubeChatConnection.instance.login(user).then((cubeUser) async {
        isLoading = false;
        SharedPrefs.saveNewUser(user).then((value) {
          Get.offAllNamed(AppRoutes.HOME);
          update();
        }).catchError((error) {
          print("myerror");
        });
      }).catchError((exception) {
        print(exception);
        //   _processLoginError(exception);
      });
    }).catchError((error) {});
  }

  loginUsers(LoginResponse response) {
    CubeUser user = CubeUser(
        login: "own" + response.id.toString(),
        password: 'supersecurepwd',
        email: "",
        fullName: response.name,
        phone: '',
        website: '',
        customData: "'}");

/*
    getUserByLogin("own"+response.id.toString())
        .then((cubeUser) {*/
    CubeUser users = CubeUser(
      id: 5826913,
      login: "own12",
      fullName: "Can",
      password: "supersecurepwd",
    );
    CubeChatConnection.instance.login(users).then((cubeUser) {
      Get.offAllNamed(AppRoutes.HOME);
      update();
    }).catchError((exception) {
      print(exception);
      //   _processLoginError(exception);
    });
    /*.catchError((exception) {

      signUp(user)
          .then((cubeUser) {

        signupUsers(user);

      })
          .catchError((error){});
    });*/
  }
}
