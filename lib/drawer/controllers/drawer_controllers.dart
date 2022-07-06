import 'dart:convert';

import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/src/managers/call_manager.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/pref_util.dart';

import '../../src/managers/push_notifications_manager.dart';


class DrawersController extends GetxController with WidgetsBindingObserver {
  var scaffoldkeys = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  var userlogin = GetStorage();
  int count = 0;

  @override
  void onInit() {
    // getCounts();

    super.onInit();
    WidgetsBinding.instance!.addObserver(this);
    print("Countsss" + count.toString());
  }

  @override
  void onReady() {
    //getCounts();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("myresumed");
    } else if (state == AppLifecycleState.inactive) {
      print("MyInactive");
    } else if (state == AppLifecycleState.paused) {
      print("paused");
    } else if (state == AppLifecycleState.detached) {
      print("deteched");
    }
  }



  void navigateBoxScreen() {
    Get.toNamed(AppRoutes.select_payment);
  }

  void navigateFavBoxScreen() {
    Get.toNamed(AppRoutes.favourite);
  }
  void navigateBoxChat() {

    Get.toNamed(AppRoutes.chat);

  }

  void navigateBoxReviews() {

    Get.toNamed(AppRoutes.reviews);

  }
  void snackBar() {
    AppUtils.Snackbar("title", "message");
  }

  handleDrawer() {
    if (scaffoldkeys.currentState != null) {
      scaffoldkeys.currentState!.openEndDrawer();
    }
  }

  void logout({required onLogoutSuccess}) {

    String token = GetStorage().read(GetConstant.token);
    ApiHelper.delete(NetworkUtils.log_out, authtoken: token).then((value) async {
      if (value!.statusCode == 200) {
        AppUtils.Snackbar("Success", "You have logout successfully");
        userlogin.erase();
        CallManager.instance.destroy();
        CubeChatConnection.instance.destroy();
        await PushNotificationsManager.instance.unsubscribe();
        await SharedPrefs.deleteUserData();
        await signOut();
       Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        dynamic resp = jsonDecode(value.data);
        AppUtils.Snackbar("Failure", resp["message"] ?? 'Something went wrong');
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      AppUtils.Snackbar("Failure", error.toString());
    });
  }

  setLoading(bool value) {
    isLoading = value;
    update();
  }
}
