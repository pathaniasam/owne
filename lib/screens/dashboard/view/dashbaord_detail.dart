import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/add_cost/controller/add_cost_controller.dart';
import 'package:ownervet/screens/auth/controller/claim_controller.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/screens/reviews/controllers/all_review_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardDetails extends GetView<DashBoardDetailController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.delete<DashBoardDetailController>();
          Get.back();

          return false;
        },
        child: GetBuilder<DashBoardDetailController>(
            init:
                Get.put<DashBoardDetailController>(DashBoardDetailController()),
            builder: (controller) {
              //controller.onInit();
              return Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightgrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.currency == "USD"
                                    ? Text(
                                        "\$ " +
                                            controller.grandTotal
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18, color: Colors.black))
                                    : Text(
                                        controller.grandTotal
                                                .toStringAsFixed(2) +
                                            " CAD",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18, color: Colors.black)),
                                ElevatedButton(
                                    child: Text("Next".toUpperCase(),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14, color: Colors.white)),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.ButtonColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(color: AppColors.ButtonColor)))),
                                    onPressed: () {
                                      if (controller.addServices.length == 0) {
                                        AppUtils.Snackbar(
                                            "Services", "Please add Services");
                                      } else {
                                        Get.toNamed(AppRoutes.book_home);
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: controller.isDashLoad
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        width: double.infinity,
                                        imageUrl: controller.detailResponse
                                                    .user!.profileImage ==
                                                null
                                            ? ""
                                            : controller.detailResponse.user!
                                                .profileImage!,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/rectangle.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                          right: 5,
                                          top: 10,
                                          child: controller
                                                  .detailResponse.isFavourite!
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 15),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .callFavouriteApi();
                                                      controller.updateFavourite(
                                                          !controller
                                                              .detailResponse
                                                              .isFavourite!);
                                                    },
                                                    icon: Icon(CupertinoIcons
                                                        .heart_solid),
                                                    color: Colors.red,
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      left: 5, right: 15),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .callFavouriteApi();
                                                      controller.updateFavourite(
                                                          !controller
                                                              .detailResponse
                                                              .isFavourite!);
                                                    },
                                                    icon: Icon(
                                                        CupertinoIcons.heart),
                                                    color: Colors.black,
                                                  ),
                                                ))
                                    ],
                                  ),
                                ),
                                /*       SliverAppBar(
                            expandedHeight: 200.0,
                            floating: false,
                            pinned: true,
                            leading: IconButton(icon:Icon(Icons.arrow_back_ios_new_rounded),color: Colors.black,onPressed: (){
                              Get.delete<DashBoardDetailController>();
                              Get.back();
                            },),
                            actions: [
                              controller.detailResponse.isFavourite!?   Container(
                                margin: EdgeInsets.only(left: 5,right: 15),
                                child: IconButton(onPressed:(){
                                  controller.callFavouriteApi();
                                  controller.updateFavourite(!controller.detailResponse.isFavourite!);
                                },icon:Icon(CupertinoIcons.heart_solid),color: Colors.red,),)  :  Container(
                                margin: EdgeInsets.only(left: 5,right: 15),
                                child: IconButton(onPressed:(){
                                  controller.callFavouriteApi();
                                  controller.updateFavourite(!controller.detailResponse.isFavourite!);
                                },icon:Icon(CupertinoIcons.heart),color: Colors.black,),)
                            ],
                            flexibleSpace: FlexibleSpaceBar(
                                centerTitle: true,
                                background: CachedNetworkImage(
                                  imageUrl:controller.detailResponse.user!.profileImage==null?"": controller.detailResponse.user!.profileImage!,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) => Image.asset("assets/images/rectangle.png"),
                                  fit: BoxFit.cover,
                                )),
                          ),*/
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Text(
                                      controller.detailResponse.user!.name!,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/check.png"),
                                    Text(
                                      "verified",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    AllReviewController reviews =
                                        Get.put<AllReviewController>(
                                            AllReviewController());

                                    reviews.id = controller.id;
                                    Get.toNamed(AppRoutes.allReviews);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${4.8}${"(${158})"}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      RatingBarIndicator(
                                        rating: controller
                                                    .detailResponse.avgRating ==
                                                null
                                            ? 3
                                            : controller
                                                .detailResponse.avgRating!
                                                .toDouble(),
                                        itemCount: 5,
                                        itemSize: 15,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                controller.detailResponse.tagline == null
                                    ? Container()
                                    : Container(
                                        child: Text(controller
                                            .detailResponse.tagline!)),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        urlLancher(
                                            controller.detailResponse.website!);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.lightgrey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: AppColors.lightgrey)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  "assets/images/web.png"),
                                              Text("Website")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            ('tel://${controller.detailResponse!.contact}'));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.lightgrey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: AppColors.lightgrey)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  "assets/images/phone.png"),
                                              Text("Contact")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.lightgrey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: AppColors.lightgrey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                                "assets/images/time.png"),
                                            Text("Hours")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                controller.detailResponse.claimed!
                                    ? Container()
                                    : OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          side: BorderSide(
                                              width: 1, color: Colors.black),
                                        ),
                                        onPressed: () {
                                          ClaimControllerController response =
                                              Get.put<ClaimControllerController>(
                                                  ClaimControllerController());
                                          response.id = controller.id;
                                          Get.toNamed(AppRoutes.claim);
                                        },
                                        child: Text(
                                          'Claim This Business',
                                          style: GoogleFonts.montserrat(
                                              color: Colors.black),
                                        ),
                                      ),
                                controller.detailResponse.claimed!
                                    ? Container()
                                    : Divider(),
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        color: AppColors.lightgrey,
                                        child: Center(
                                            child: Text(
                                          controller.detailResponse.address!,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                        )),
                                      ),
                                      Positioned(
                                          right: 20,
                                          top: -20,
                                          child: GestureDetector(
                                              onTap: () {
                                                openMap();
                                              },
                                              child: Image.asset(
                                                  "assets/images/direction.png")))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(top: 0, bottom: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(
                                                    "assets/images/cash.png"),
                                                backgroundColor:
                                                    AppColors.lightgrey,
                                              ),
                                              Text(controller.payment[0])
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(
                                                    "assets/images/credit.png"),
                                                backgroundColor:
                                                    AppColors.lightgrey,
                                              ),
                                              Text(controller.payment[1])
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                child: Image.asset(
                                                    "assets/images/finacement.png"),
                                                backgroundColor:
                                                    AppColors.lightgrey,
                                              ),
                                              Text(controller.payment[2])
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 10),
                                    width: double.infinity,
                                    child: Text(
                                      "Spotlight",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )),
                                controller.detailResponse.services == null
                                    ? Container()
                                    : SizedBox(
                                        height: 120,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller.detailResponse
                                                .services!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return controller
                                                          .detailResponse
                                                          .services![index]
                                                          .service!
                                                          .image ==
                                                      null
                                                  ? Container()
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15, top: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child:
                                                                  Image.network(
                                                                controller
                                                                    .detailResponse
                                                                    .services![
                                                                        index]
                                                                    .service!
                                                                    .image!,
                                                                height: 55,
                                                                width: 55,
                                                              )),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                right: 14,
                                                              ),
                                                              child: Text(
                                                                controller
                                                                    .detailResponse
                                                                    .services![
                                                                        index]
                                                                    .service!
                                                                    .name!,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        11),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              width: 68,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            })),
                                Container(
                                  width: double.infinity,
                                  height: 30,
                                  color: AppColors.lightgrey,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: AppColors.lightgrey
                                                .withAlpha(70),
                                          ),
                                          child: DropdownButtonFormField2(
                                            decoration: InputDecoration(
                                              //Add isDense true and zero Padding.
                                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                              isDense: true,
                                              fillColor: Colors.green,

                                              contentPadding: EdgeInsets.zero,
                                              errorStyle: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: "Quicksand",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.green),

                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: AppColors.green),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              //Add more decoration as you want here
                                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                            ),
                                            isExpanded: true,
                                            hint: const Text(
                                              ' Choose Service',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            icon: const Icon(
                                              CupertinoIcons.chevron_down,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                            iconSize: 30,
                                            buttonHeight: 40,
                                            buttonPadding:
                                                const EdgeInsets.only(
                                                    left: 6, right: 6),
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            items: controller.genderItems
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select gender.';
                                              }
                                            },
                                            onChanged: (value) {
                                              //Do something when changing the item if you want.
                                              controller.speciesGenderFilter(
                                                  value.toString());
                                            },
                                            onSaved: (value) {
                                              print(value.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      controller.detailResponse.claimed!
                                          ? Container()
                                          : Container(
                                              height: 40,
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: Container(
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      AddCostController
                                                          response =
                                                          Get.put<AddCostController>(
                                                              AddCostController());
                                                      response.servicesList =
                                                          controller
                                                              .detailResponse
                                                              .services;
                                                      response.professsionalId =
                                                          int.parse(
                                                              controller.id!);
                                                      //  response.currency=int.parse(controller.id!);
                                                      Get.toNamed(
                                                          AppRoutes.add_cost);
                                                    },
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: AppColors
                                                                      .darkYellow))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed))
                                                            return Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(
                                                                    0.5);
                                                          return AppColors
                                                              .darkYellow; // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            "Report Cost",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ) /*CustomTextButton(
      buttonColor: AppColors.lightYellow,
      title:"Report Cost",
      textColor:Colors.black,
      onPressed: () {
        AddCostController response=Get.put<AddCostController>(AddCostController());
        response.servicesList=controller.detailResponse.services;
        response.professsionalId=int.parse(controller.id!);
      //  response.currency=int.parse(controller.id!);
        Get.toNamed(AppRoutes.add_cost);
       // controller.callCreateQuestion(controller.questionController.text);
      },
  )*/
                                              ,
                                            ),
                                    ],
                                  ),
                                ),

                                /* Expanded(
                    child: ListView.builder(
                      itemCount: controller.imagesVet.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context,int index)
                      {
                        return Container(
                          margin: EdgeInsets.only(top: 0,bottom: 25),
                          child: Image.asset(controller.imagesVet[index]),
                        );

                      },
                    ),
                  ),*/

                                SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.filterServices.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  controller
                                                      .detailResponse
                                                      .services![index]
                                                      .service!
                                                      .name!,
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "${double.parse(controller.detailResponse.services![index].price.toString()).toStringAsFixed(2)}${controller.currency == " USD" ? "\$" : " CAD"}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      "${controller.detailResponse.services![index].priceType}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Checkbox(
                                                      checkColor: Colors.white,
                                                      activeColor:
                                                          AppColors.ButtonColor,
                                                      value: controller
                                                                  .detailResponse
                                                                  .services![
                                                                      index]
                                                                  .isTrue !=
                                                              null
                                                          ? controller
                                                              .detailResponse
                                                              .services![index]
                                                              .isTrue!
                                                          : false,
                                                      onChanged: (bool? value) {
                                                        if (value == null
                                                            ? false
                                                            : value) {
                                                          controller.addVServices(
                                                              index,
                                                              value,
                                                              controller
                                                                  .detailResponse
                                                                  .services![index]);
                                                        } else {
                                                          controller.addVServices(
                                                              index,
                                                              false,
                                                              controller
                                                                  .detailResponse
                                                                  .services![index]);
                                                        }
                                                      },
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            )),
                  ));
            }));
  }

  Future<void> openMap() async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url =
          'https://www.google.com/maps/search/?api=1&query=${controller.detailResponse.lat},${controller.detailResponse.lng}';
    } else {
      urlAppleMaps =
          'https://maps.apple.com/?q=${controller.detailResponse.lat},${controller.detailResponse.lng}';
      url =
          'comgooglemaps://?saddr=&daddr=${controller.detailResponse.lat},${controller.detailResponse.lng}&directionsmode=driving';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }

  void urlLancher(String weburls) async {
    var url = weburls;
    if (!url.substring(0, 5).contains('http')) {
      url = 'https://' + url;
    }
    //var urls = "https://${url}";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
