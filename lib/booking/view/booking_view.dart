import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/booking/controller/booking_controller.dart';
import 'package:ownervet/deals/controller/appointment_detail_controller.dart';
import 'package:ownervet/drawer/view/drawer_screen.dart';
import 'package:ownervet/model/response/all_appointment_response.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/get_constant.dart';

class BookingView extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
        init: Get.put<BookingController>(BookingController()),
        builder: (controller) {
          //controller.onInit();
          return Scaffold(
            key: controller.scaffoldkey,
            drawer: Container(
                width: MediaQuery.of(context).size.width * 0.85, //20.0,,
                child: DrawerMenu()),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.openDrawer();
                          },
                          child: Image.asset("assets/images/menu.png")),
                      controller.userLogin.read(GetConstant.image) != null
                          ? GestureDetector(
                              onTap: () {
                                Get.offNamed(AppRoutes.myprofile);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: CachedNetworkImage(
                                  imageUrl: controller.userLogin
                                      .read(GetConstant.image),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            )
                          : Image.asset("assets/images/dog.png")
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bookings",
                          style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        /*    Container(
                   height: 30,
                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10.0),
                       color: AppColors.grey.withAlpha(30),
                       border: Border.all()),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton<String>(
                       items: <String>['All', 'Today', 'C', 'D'].map((String value) {
                         return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value,style: TextStyle(color: Colors.black),),
                         );
                       }).toList(),
                       onChanged: (_) {},
                     ),
                   ),
                 )*/
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Your Appointments!",
                      style: GoogleFonts.montserrat(
                        color: AppColors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Today:",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: NotificationListener(
                        onNotification: (t) {
                          if (t is ScrollEndNotification) {
                            if ((controller.scrollcontroller.position.pixels ==
                                    controller.scrollcontroller.position
                                        .maxScrollExtent) &&
                                (controller.response!.pageInfo!.hasMoreData ??
                                    false)) {
                              print("true");
                            } else {
                              print("false");
                            }
                          } else {
                            print("falsesss");
                          }
                          return true;
                        },
                        child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 60),
                            itemCount: controller.data.length,
                            controller: controller.scrollcontroller,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  AppointmentDetailController request =
                                      Get.put<AppointmentDetailController>(
                                          AppointmentDetailController());
                                  request.id = controller.data[index].id;
                                  Get.toNamed(AppRoutes.appointemntDetail);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: IntrinsicHeight(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors.lightYellow
                                                      .withAlpha(30),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        spiltTiming(AppUtils()
                                                            .getDateCompletes(
                                                                controller
                                                                    .data[index]
                                                                    .timing)),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: AppColors
                                                              .lightYellow,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4.0,
                                                                    right: 4.0,
                                                                    top: 4.0,
                                                                    bottom:
                                                                        4.0),
                                                            child: Text(
                                                              controller
                                                                  .data[index]
                                                                  .type!,
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .data[
                                                                                  index]
                                                                              .type ==
                                                                          "Call Appointment"
                                                                      ? AppColors
                                                                          .red
                                                                      : Colors
                                                                          .blue,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              border: Border.all(
                                                                  color: controller
                                                                              .data[
                                                                                  index]
                                                                              .type ==
                                                                          "Call Appointment"
                                                                      ? AppColors
                                                                          .red
                                                                      : Colors
                                                                          .blue,
                                                                  width: 1)),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          child: OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              side: BorderSide(
                                                                  width: 1,
                                                                  color: controller
                                                                              .data[
                                                                                  index]
                                                                              .status ==
                                                                          "Confirmed"
                                                                      ? Colors
                                                                          .green
                                                                      : controller.data[index].status ==
                                                                              "Pending"
                                                                          ? Colors
                                                                              .orange
                                                                          : Colors
                                                                              .red),
                                                            ),
                                                            onPressed: () {},
                                                            child: Text(
                                                              controller
                                                                  .data[index]
                                                                  .status!,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 12,
                                                                  color: controller.data[index].status == "Confirmed"
                                                                      ? Colors.green
                                                                      : controller.data[index].status == "Pending"
                                                                          ? Colors.orange
                                                                          : Colors.red),
                                                            ),
                                                          ),
                                                          height: 20,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  top: 10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: controller
                                                                .data[index]
                                                                .professional!
                                                                .user!
                                                                .profileImage!,
                                                            progressIndicatorBuilder: (context,
                                                                    url,
                                                                    downloadProgress) =>
                                                                CircularProgressIndicator(
                                                                    value: downloadProgress
                                                                        .progress),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    "assets/images/rectangle.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 4,
                                                                    right: 4,
                                                                    top: 10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .data[
                                                                          index]
                                                                      .professional!
                                                                      .user!
                                                                      .name!,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        getService(controller
                                                                            .data[index]
                                                                            .services!),
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                          "Checkup",
                                                                          style:
                                                                              GoogleFonts.montserrat(color: Colors.black),
                                                                        ),
                                                                        Text(
                                                                            "${getTotal(controller.data[index].services!)}",
                                                                            style: GoogleFonts.montserrat(
                                                                                fontSize: 18,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ],
                                                                    )
                                                                  ],
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  String getService(List<Services> list) {
    String name = "";
    list.forEach((element) {
      name += element.name.toString();
    });
    return name;
  }

  getTotal(List<Services> list) {
    double price = 0.0;
    String currencys = "";
    list.forEach((element) {
      price += double.parse(element.price!);
      currencys = element.currency!;
      print(element.currency!);
    });
    return "${price.toStringAsFixed(2)}${currencys.isEmpty ? "CAD" : "\$"}";
  }

  String spiltTiming(String value) {
    var str = value;
    var parts = str.split(" ");
    return parts[0] + "\n" + parts[1];
  }
}
