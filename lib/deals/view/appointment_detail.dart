import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:ownervet/deals/controller/appointment_detail_controller.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/reviews/controllers/reviews_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';

class AppointmentDetailView extends GetView<AppointmentDetailController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<AppointmentDetailController>();
        Get.back();

        return false;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppUtils().appBar(
                "Appointment",
                "assets/images/cancel.png",
                "assets/images/three_dot.png",
                endIcon,
                leadingIcon,
              )),
          body: GetBuilder<AppointmentDetailController>(
              init: Get.put<AppointmentDetailController>(
                  AppointmentDetailController()),
              builder: (controller) {
                return SafeArea(
                  child: controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.green.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Image.asset(
                                        "assets/images/dp.png",
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.contain,
                                      )),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .data!.petDetail!.petName!,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 21),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/species.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(controller.data!
                                                      .petDetail!.species!),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/breed.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(controller
                                                      .data!.petDetail!.breed!),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/gender.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(controller.data!
                                                      .petDetail!.gender!),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 2),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/date.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(AppUtils()
                                                        .getDateCompletes(
                                                            controller
                                                                .data!
                                                                .petDetail!
                                                                .dob!)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/weights.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(controller
                                                      .data!.petDetail!.weight!
                                                      .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              width: double.infinity,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  "Appointment Info".toUpperCase(),
                                  style: GoogleFonts.montserrat(fontSize: 17),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/icons.png"),
                                SizedBox(
                                  width: 4,
                                  height: 6,
                                ),
                                Text(AppUtils()
                                    .getDateCompletes(controller.data!.timing)),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/time.png"),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(AppUtils()
                                    .getDateComplete(controller.data!.timing)),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/phone.png"),
                                SizedBox(
                                  width: 4,
                                  height: 6,
                                ),
                                Text(controller.data!.type!),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                child: Row(
                              children: [
                                Text(
                                  "NOTE",
                                  style: GoogleFonts.montserrat(fontSize: 21),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Image.asset("assets/images/edit.png"),
                              ],
                            )),
                            SizedBox(
                              height: 16,
                            ),
                            controller.data!.notes != null
                                ? Container(
                                    width: double.infinity,
                                    child: Text(controller.data!.notes!))
                                : Container(),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  "Services",
                                  style: GoogleFonts.montserrat(fontSize: 21),
                                )),
                            MultiSelectChipField(
                              items: controller.items,
                              showHeader: false,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              headerColor: Colors.blue.withOpacity(0.5),
                              selectedChipColor: Colors.blue.withOpacity(0.5),
                              selectedTextStyle:
                                  TextStyle(color: Colors.blue[800]),
                              onTap: (values) {
                                //_selectedAnimals4 = values;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(
                                  " ${"\$"} ${double.parse(controller.data!.subTotal.toString()).toStringAsFixed(2)} ",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            controller.data!.status == "Cancelled"
                                ? Container(
                                    margin:
                                        EdgeInsets.only(left: 40, right: 40),
                                    height: 50,
                                    child: ElevatedButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            CupertinoIcons.xmark_circle,
                                            color: Colors.white,
                                          ), //icon data for elevated button
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            'Cancelled',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),

                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                            EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8.0,
                                                left: 8)),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>((states) {
                                          return Colors.red.shade600;
                                        }),

                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5.0))),
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color>((states) {
                                          return Colors.red.shade600;
                                        }),

                                        //For text color,
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        //For border
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return BorderSide(
                                                color: Colors.red.shade600,
                                                width: 2,
                                              );
                                            else
                                              return BorderSide(
                                                  color: Colors.red.shade600,
                                                  width: 2);
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : DateTime.now().isBefore(DateFormat(
                                            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
                                        .parse(controller.data!.timing!))
                                    ? Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                            right: 15, left: 15),
                                        child: controller.isLoadings
                                            ? CircularProgressIndicator()
                                            : CustomTextButton(
                                                buttonColor:
                                                    AppColors.ButtonColor,
                                                title: "Cancel",
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  controller
                                                      .cancelledAppointment(
                                                          controller.id
                                                              .toString());
                                                },
                                              ),
                                      )
                                    : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
                                                .parse(controller.data!.timing!)
                                                .isAtSameMomentAs(
                                                    DateTime.now()) ||
                                            DateTime.now().isAfter(DateFormat(
                                                    "yyyy-MM-dd'T'HH:mm:ss.SSS'Z")
                                                .parse(
                                                    controller.data!.timing!))
                                        ? Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.only(
                                                right: 15, left: 15),
                                            child: CustomTextButton(
                                              buttonColor:
                                                  AppColors.ButtonColor,
                                              title: "Review",
                                              textColor: Colors.white,
                                              onPressed: () {
                                                ReviewsController controllers =
                                                    Get.put<ReviewsController>(
                                                        ReviewsController());
                                                controllers.id =
                                                    controller.id.toString();
                                                controllers.imageUrl =
                                                    controller
                                                        .data!
                                                        .professional!
                                                        .user!
                                                        .profileImage
                                                        .toString();
                                                Get.toNamed(AppRoutes.reviews);
                                              },
                                            ),
                                          )
                                        : Container()
                          ])),
                );
              })),
    );
  }

  endIcon() {}

  leadingIcon() {
    Get.delete<AppointmentDetailController>();
    Get.back();
  }

  void getChatStream() async {
    var collection = FirebaseFirestore.instance.collection('allusers');
    var docSnapshot = await collection.doc('SP1').get();
    print(docSnapshot);
  }
}
