import 'dart:convert';

import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/pref_util.dart';
import 'package:path/path.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CreateAccountController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  var countryCode = "+1";
  bool showPassword = true;
  var userlogin = GetStorage();
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  callRegister() async {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
//print("imagepath"+image!.path);
      final mimeTypeData =
          lookupMimeType(image!.path, headerBytes: [0xFF, 0xD8])!.split('/');
      var formData = FormData.fromMap({
        'name': nameController.text,
        'email': emailController.text,
        'mobile': phoneController.text,
        'account_source': "manual",
        'password': passwordController.text,
        'image': await MultipartFile.fromFile(image!.path,
            filename: basename(image!.path),
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
      });
      isLoading = true;
      update();
      ApiHelper.post(NetworkUtils.register_api, formData: formData)
          .then((value) {
        if (value!.statusCode == 201) {
          LoginResponse response =
              LoginResponse.fromJson(jsonDecode(value.data));
          userlogin.write(GetConstant.name, response.name);
          userlogin.write(GetConstant.token, response.token);
          AppUtils.Snackbar("Success", "You have successfully login");
          isLoading = false;
          loginUsers(response);
       //   Get.offAllNamed(AppRoutes.HOME);

          update();
          print("Success");
          print("Success");
        } else {
          LoginResponse response =
              LoginResponse.fromJson(jsonDecode(value.data));
          isLoading = false;

          AppUtils.Snackbar("Error", response.message);
          update();
        }
      });
    }
  }

  pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

  updateCountryCode(String code) {
    countryCode = code;
    update();
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
