

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/select_payment/controller/payment_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';


class PaymentScreen extends GetView<PaymentControllers>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async {
    Get.delete<PaymentControllers>();
    Get.back();

    return false;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppUtils().appBar(
                "Payment",
                "assets/images/cancel.png",
                "assets/images/help.png",
                endIcon,
                leadingIcon,
              )),
        body:  GetBuilder<PaymentControllers>(
          init:
          Get.put<PaymentControllers>(PaymentControllers()),
      builder: (controller) {
      //controller.onInit();
      return SafeArea(
      child:
      Column(
      children: [
      SizedBox(height: 20,),
      CardField(
      autofocus: true,
      onCardChanged: (card) {
      // contrcard = card;
      controller.updateCard(card);
      },
      ),
      SizedBox(height: 10,),
  controller.isLogin?Center(child: CircularProgressIndicator(),):    Container(
      width: double.infinity,
      margin: EdgeInsets.only(
      left: 20, right: 20, top: 15),
      child: CustomTextButton(
      buttonColor: AppColors.ButtonColor,
      title: "SUBMIT",
      textColor: Colors.white,
      onPressed: () {
      controller.callPayemnt();
      }),
      ),
      ],
      ),
      );
      })),
    );
  }


  endIcon() {
  }
  leadingIcon(){
    Get.delete<PaymentControllers>();
    Get.back();
  }
}