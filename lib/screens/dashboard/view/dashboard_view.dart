import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ownervet/drawer/view/drawer_screen.dart';
import 'package:ownervet/model/response/dashboard_response.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_controller.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/strings.dart';

class DashboardView extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
        init: Get.put<DashBoardController>(DashBoardController()),
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
                        controller.userlogin.read(GetConstant.image) != null
                            ? GestureDetector(
                                onTap: () {
                                  Get.offNamed(AppRoutes.myprofile);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.userlogin
                                        .read(GetConstant.image),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
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
                            : GestureDetector(
                                onTap: () {
                                  Get.offNamed(AppRoutes.myprofile);
                                },
                                child: Image.asset("assets/images/dog.png"))
                      ],
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Hey, ${controller.userlogin.read(GetConstant.name)}",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.black),
                        ),
                        Text(
                          Strings.dashBoardTitle,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                              itemCount: controller.categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedIndexCategory(index);
                                    controller.callCategoryData();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: 16, top: 10),
                                        decoration: BoxDecoration(
                                            color: controller.selectedIndex ==
                                                    index
                                                ? AppColors.ButtonColor
                                                : AppColors.greyShade,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.network(
                                            '${controller.categories[index].image}',
                                            fit: BoxFit.fill,
                                            height: 35,
                                            width: 35,
                                            color: controller.selectedIndex ==
                                                    index
                                                ? Colors.white
                                                : Colors.black,
                                            semanticsLabel: 'A shark',
                                            placeholderBuilder: (BuildContext
                                                    context) =>
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
                                                    child:
                                                        const CircularProgressIndicator(
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                    )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: 14,
                                          ),
                                          child: Text(
                                            controller.categories[index].name!,
                                            style: TextStyle(
                                                color:
                                                    controller.selectedIndex ==
                                                            index
                                                        ? Colors.black
                                                        : Colors.grey,
                                                fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                          width: 60,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        TextField(
                          controller: controller.searchController,
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              controller.callSearchCategoryData(value);
                            }
                          },
                          decoration: InputDecoration(
                            isDense:
                                true, // this will remove the default content padding

                            hintText: "Search for venterinarian",
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: controller.searchController.text.isEmpty
                                ? null
                                : InkWell(
                                    onTap: () =>
                                        controller.searchController.clear(),
                                    child: Icon(Icons.clear),
                                  ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset("assets/images/location_arrow.png"),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Nearby Veterinarian",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "3 KM",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  controller.data != null
                      ? Expanded(
                          child: NotificationListener(
                          onNotification: (t) {
                            if (t is ScrollEndNotification) {
                              if ((controller
                                          .scrollcontroller.position.pixels ==
                                      controller.scrollcontroller.position
                                          .maxScrollExtent) &&
                                  (controller
                                          .responses!.pageInfo!.hasMoreData ??
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
                              itemCount: controller.data.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 20),
                              controller: controller.scrollcontroller,
                              itemBuilder: (context, index) {
                                return detailsWidget(controller.data[index]);
                              }),
                        ))
                      : Container()
                ],
              )));
        });
  }

  Widget detailsWidget(HomeData result) {
    return InkWell(
      onTap: () {
        DashBoardDetailController response =
            Get.put<DashBoardDetailController>(DashBoardDetailController());
        response.id = result.id.toString();
        Get.toNamed(AppRoutes.detail_home);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(40),
                          borderRadius: BorderRadius.circular(15)),
                      child: result.profileImage == null
                          ? Container()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: result.profileImage!,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/rectangle.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              result.name!,
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            result.address == null
                                ? Text(
                                    result.address!,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    result.address!,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  size: 15,
                                ),
                                Text(
                                  double.parse(result.distance.toString())
                                          .toStringAsFixed(2) +
                                      " KM",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.time,
                      color: AppColors.green,
                      size: 10,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    result.days == null
                        ? Container()
                        : Text(result.days!,
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${DateFormat.jm().format(DateFormat("hh:mm").parse(result.openTime.toString()))}${" - "}${DateFormat.jm().format(DateFormat("hh:mm").parse(result.closeTime.toString()))}",
                      style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    RatingBarIndicator(
                      rating:
                          result.rating == null ? 3 : result.rating!.toDouble(),
                      itemCount: 5,
                      itemSize: 15,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 5,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*  Widget detailsWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              */ /* Container(
                height: 60,
                width: 60,
                child:CachedNetworkImage(
                  imageUrl: result.picture!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),),*/ /*
              Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(left: 8,top: 10),
                  child:Image.asset("assets/images/rectangle.png")),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 4,right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Mission Pet Hospital", style: GoogleFonts.montserrat(
                          fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),),
                      Text("20 Valencia St, San Francisco,CA \n94110, United States", style: GoogleFonts.montserrat(
                          fontSize: 12, color: Colors.black,fontWeight: FontWeight.w400),),

                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(CupertinoIcons.location,size: 15,),
                          Text("1.5"+"Km",style: GoogleFonts.montserrat(
                              fontSize: 10, color: Colors.black,fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Icon(CupertinoIcons.time,color:AppColors.green,size: 10,),
              Text("Monday-Friday at 8.00 AM-4.00 AM",style: GoogleFonts.montserrat(
                  fontSize: 12, color: Colors.black,fontWeight: FontWeight.w500),),
              Spacer(),
              RatingBar.builder(


                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15,

                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 5,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
          SizedBox(height: 8,),

          Divider(color: Colors.black,)
        ],
      ),
    );
  }*/

}
