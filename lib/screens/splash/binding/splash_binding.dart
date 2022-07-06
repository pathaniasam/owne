import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(),);
  }

}