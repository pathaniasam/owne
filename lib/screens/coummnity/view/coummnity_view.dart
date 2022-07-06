

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/drawer/view/drawer_screen.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/addquestionanswer/controller/question_detail_controller.dart';
import 'package:ownervet/screens/coummnity/controller/coummnity_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:share_plus/share_plus.dart';

class CoummnityView extends GetView<CoummnityController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoummnityController>(
        init: Get.put<CoummnityController>(CoummnityController()),
        builder: (controller) {
          return Scaffold(
              drawer: Container(
                  width: MediaQuery.of(context).size.width * 0.85,//20.0,,
                  child: DrawerMenu()),
              key: controller.scaffoldkey,
              appBar: PreferredSize(preferredSize: Size.fromHeight(80),
                child: SafeArea(
                  child:  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.openDrawer();
                            },
                            child: Image.asset("assets/images/menu.png")),
                        controller.userlogin.read(GetConstant.image)!=null? GestureDetector(
                          onTap: (){
                            Get.offNamed(AppRoutes.myprofile);

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),

                            child: CachedNetworkImage(
                              imageUrl: controller.userlogin.read(GetConstant.image),
                              progressIndicatorBuilder: (context, url,
                                  downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ):               GestureDetector(
                          onTap: (){
                            Get.offNamed(AppRoutes.myprofile);

                          },
                            child: Image.asset("assets/images/dog.png"))
                      ],
                    ),
                  ),
                ),


              ),
              floatingActionButton: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: FloatingActionButton(

                    onPressed: () {
                      print("Hii");
                      Get.toNamed(AppRoutes.AddQuestion)!.then((value) {
                        controller.getAllQuestion();
                      });
                    },
                    child: Icon(Icons.add,),
                    backgroundColor: AppColors.ButtonColor,
                    mini: true,
                  ),
                ),
              ),
              body: SafeArea(
                  child:
                  controller.isLoading?Center(child: CircularProgressIndicator(),):   Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 15,bottom: 15,),
                              child: Text("Community", textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                            ),
                            Expanded(
                              child: NotificationListener(
                                onNotification: (t) {
                                  if (t is ScrollEndNotification) {
                                    if ((controller.scrollcontroller.position
                                        .pixels ==
                                        controller.scrollcontroller.position
                                            .maxScrollExtent) &&
                                        (controller.coummnityResponse!.pageInfo!
                                            .hasMoreData ?? false)) {
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
                                    padding: EdgeInsets.only(bottom: 30),
                                    controller: controller.scrollcontroller,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {

                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 10,
                                                bottom: 10),

                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 15,
                                                        width: 15,
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue.withAlpha(40),
                                                            borderRadius: BorderRadius.circular(15)
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                          child: CachedNetworkImage(
                                                            imageUrl:  controller
                                                                .data[index].user!
                                                                .profileImage!,
                                                            progressIndicatorBuilder: (
                                                                context, url,
                                                                downloadProgress) =>
                                                                CircularProgressIndicator(
                                                                    value: downloadProgress
                                                                        .progress),
                                                            errorWidget: (context,
                                                                url, error) =>
                                                                Image.asset("assets/images/rectangle.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Container(

                                                              child: Text(
                                                                controller
                                                                    .data[index]
                                                                    .user!.name!,
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                    fontSize: 11,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight: FontWeight
                                                                        .w500),),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  left: 4),),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(AppUtils()
                                                          .getDateComplete(
                                                          controller.data[index]
                                                              .createdAt),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                            fontSize: 8,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight
                                                                .w400),)
                                                    ],
                                                  ),
                                                  Container(

                                                    child: Text(
                                                      controller.data![index]
                                                          .question!,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          fontSize: 11,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .w400),),
                                                    margin: EdgeInsets.only(
                                                        left: 17,
                                                        right: 15,
                                                        top: 8),),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15, top: 8),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/answer.png"),
                                                        SizedBox(width: 4,),
                                                        GestureDetector(
                                                          onTap: (){
                                                            AddQuestionDetailController addQuestDetailController = Get
                                                                .put<AddQuestionDetailController>(
                                                                AddQuestionDetailController());
                                                            addQuestDetailController.id =
                                                                controller.data[index].id;
                                                            addQuestDetailController
                                                                .questionData =
                                                            controller.data[index];
                                                            Get.toNamed(AppRoutes.detailQuestion)!
                                                                .then((value) {
                                                              Get.delete<
                                                                  AddQuestionDetailController>();
                                                            });
                                                          },
                                                          child: Text("Answer",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                color: AppColors
                                                                    .green,
                                                                fontSize: 12,fontWeight: FontWeight.w500),),
                                                        ),
                                                        SizedBox(width: 8,),

                                                        GestureDetector(
                                                          onTap: (){
                                                            Share.share(controller.data[index].question!);
                                                          },
                                                          child: Image.asset(
                                                              "assets/images/share.png"),
                                                        ),
                                                        SizedBox(width: 2,),
                                                        GestureDetector(
                                                          onTap: (){
                                                            Share.share(controller.data[index].question!);

                                                          },
                                                          child: Text("Share",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                color: Colors.blue,
                                                                fontSize: 12,fontWeight: FontWeight.w500),),
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),


                            )
                          ]))));
        });
  }
}




