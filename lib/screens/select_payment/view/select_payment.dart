import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/select_payment/controller/payment_controller.dart';
import 'package:ownervet/screens/select_payment/controller/select_payment_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';

class SelectPayment extends GetView<SelectPaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppUtils().appBar(
            "Select Payment",
            "assets/images/cancel.png",
            "assets/images/help.png",
            endIcon,
            leadingIcon,
          )),
      body: GetBuilder<SelectPaymentController>(
          init: Get.put<SelectPaymentController>(SelectPaymentController()),
          builder: (controller) {
            //controller.onInit();
            return SafeArea(
                child: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.subscription == null
                                ? Container()
                                : Text(
                                    "Current Subscription",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.titleColor),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            controller.subscription == null
                                ? Container()
                                : Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.subscription!
                                                .subscription!.planName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          Text(
                                              "${controller.subscription!.subscription!.planValidity}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          Text(
                                              "\$" +
                                                  double.parse(controller
                                                          .subscription!
                                                          .subscription!
                                                          .planPrice!)
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                          Text(
                                              "End Date : " +
                                                  AppUtils().getDateComplete(
                                                      controller
                                                          .subscription!
                                                          .subscription!
                                                          .validityEndOn!),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ),
                            controller.subscription == null
                                ? Container()
                                : SizedBox(
                                    height: 15,
                                  ),
                            controller.subscription == null
                                ? Container()
                                : Row(
                                    children: [
                                      Expanded(
                                          child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                      )),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Select Plan",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.titleColor),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color: Colors.black,
                                        thickness: 1,
                                      )),
                                    ],
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: controller.response!.plans!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        PaymentControllers controllers =
                                            Get.put<PaymentControllers>(
                                                PaymentControllers());
                                        controllers.id = controller
                                            .response!.plans![index].id;
                                        Get.toNamed(AppRoutes.payment);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.response!
                                                    .plans![index].nickname!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                  "${controller.response!.plans![index].recurring!.intervalCount.toString()} ${controller.response!.plans![index].recurring!.interval.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                              Text(
                                                  "\$" +
                                                      getPrice(controller
                                                          .response!
                                                          .plans![index]
                                                          .unitAmount!),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ));
          }),
    );
  }

  endIcon() {}
  leadingIcon() {
    Get.back();
  }

  String getPrice(int value) {
    double price = value / 100;
    return price.toStringAsFixed(2);
  }
}
