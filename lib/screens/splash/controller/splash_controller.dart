


import 'package:get/get.dart';
import 'package:ownervet/routes/app_routes.dart';

class SplashController extends GetxController{
  var isStopTimer=false.obs;

  @override
  void onInit() {
    super.onInit();

    setTimer();
  }

  void setTimer() {
    Future.delayed(Duration(seconds: 3), () {
      isStopTimer(true);
      Get.offAndToNamed(AppRoutes.INTRO);


    });
  }

  @override
  void dispose() {
    super.dispose();

  }
}