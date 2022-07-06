import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/intro/controllers/intro_controllers.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/dot_indicator.dart';


class IntroScreen extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              PageView.builder(
                  controller: controller.pageControll.value,
                  itemCount: controller.onBoardPages.length,
                  onPageChanged: controller.selectedPagexNumber,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return createIntroScreens(index, context);
                  })
            ],
          );
        }),
      ),
    );
  }

  Widget createIntroScreens(index, BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16,),
                Text("FAREVET",
                  style: TextStyle(
                    color: AppColors.text_color,
                    fontSize: 34,
                    fontFamily: 'SF',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.onBoardPages[index].headTitle,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SF',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      controller.onBoardPages[index].discription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SF',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .04,
                    ),
                    child: Image.asset(
                      controller.onBoardPages[index].pngimage,

                      fit: BoxFit.cover,
                    )),
                DotsIndicator(
                  controller: controller.pageControll.value,
                  itemCount: controller.onBoardPages.length,
                  currentPage: controller.selectedPagexNumber.value,
                ),

              ],
            )),
        Positioned(
          bottom: 30,
          left: 10,
          right: 10,
          child: Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child: CustomTextButton(
              buttonColor: AppColors.ButtonColor,
              title:"Next",
              textColor:Colors.white,
              onPressed: () {
                if (controller.selectedPagexNumber.value < 2) {
                  controller.countIncrease();
                  controller.pageControll.value
                      .jumpToPage(controller.increaseCount.value);
                } else {
                 Get.offNamedUntil(AppRoutes.LOGIN, (route) => false);
                }
              },
            ),
          ),
        ),

      ],
    );
  }
}
