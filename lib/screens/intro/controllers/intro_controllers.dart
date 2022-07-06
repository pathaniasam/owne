import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ownervet/model/request/onboard.dart';
import 'package:ownervet/routes/app_routes.dart';


class IntroController extends GetxController {
  var selectedPagexNumber = 0.obs;
  Rx<PageController> pageControll = PageController(
    initialPage: 0,
    keepPage: true,
  ).obs;

  bool get isLastPage => selectedPagexNumber.value == onBoardPages.length - 1;
  var increaseCount = 0.obs;

  void countIncrease() {
    increaseCount = increaseCount + 1;
  }

  forwardAct() {
    //if(isLastPage) Get.offNamedUntil(signin, (route)=> false);
    if (increaseCount.value == 3) {
      print(
          "End................................................................Task");
      Get.offNamedUntil(AppRoutes.LOGIN, (route) => false);
    }
  }

  List<OnboardIntro> onBoardPages = [
    OnboardIntro("Simple & Stress Free", "Check prices faster and save more on  \n Pet Care", "assets/images/intro_one.png"),
    OnboardIntro(
     "Simple & Stress Free",
      "Video or Chat with a licensed Vet,\nAnytime, Anywhere !",
      "assets/images/intro_two.png",
    ),
    OnboardIntro(
     "Simple & Stress Free",
      "Combine discounts, deals & \nInstant booking",
      "assets/images/intro_three.png",
    ),

  ];
}
