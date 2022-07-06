

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/model/response/all_services.dart';
import 'package:ownervet/screens/search/controller/search_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_alert_dialogue.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/sub_cat_dialogue.dart';

class EndDrawer extends GetView<SearchController>{

  final String message, image, name;
  final List<ServicesData> data;

  final List<CustomTextButton> buttons;

  EndDrawer(
      {required this.name,
        required this.message,
        required this.buttons,
        required this.image,
        required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SearchController>(
            init:
            Get.put<SearchController>(SearchController()),
            builder: (controller) {
              //controller.onInit();
              return Container(

                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    height: 60,
                    color: AppColors.selectedDotColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(""),
                          Text(name,style:GoogleFonts.montserrat(color: Colors.white),),

                          GestureDetector(
                              onTap: (){
controller.filterApiCall();
Navigator.pop(context);
                              },
                              child: Text("Done",style:GoogleFonts.montserrat(color: Colors.white),)),

                        ],
                      ),
                    ),
                  ),

                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  Container(
                    color: AppColors.ButtonColor.withAlpha(20),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Pet/Type:",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500),),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                        itemCount: controller.genderItems.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                controller.selectedIndex(index);
                              },
                              child: Container(
                                width: 90,
                                margin: EdgeInsets.only(
                                    left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                    Border.all(color: controller.selectSlot != null
                                        ? controller.selectSlot==index
                                        ? AppColors.ButtonColor
                                        : Colors.black
                                        : Colors.black,width: 1),
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(controller.genderItems[index],
                                    style: TextStyle(color: controller.selectSlot==index?AppColors.ButtonColor:Colors.black),),
                                ),
                              ));
                        }),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),

                  Container(
                    width: double.infinity,

                    color: AppColors.ButtonColor.withAlpha(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Services:",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500),),
                    ),
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeLeft: true,
                      removeRight: true,
                      removeBottom: true,
                      removeTop: true,
                      child: Divider(
                        height: 1,
                        color: Colors.black,
                      )),
                  Flexible(

                    child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                if(data[index].subServices!=null){
                                  controller.categoryIndex(data[index].id!);

                                  dialogueShowFilter(context,data[index].subServices!);
                                }else{
                                  controller.categoryIndex(data[index].id!);
                                  controller.filterApiCall();
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(

                                margin: EdgeInsets.only(
                                    left: 10, right: 10),

                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Container(child: Text(data[index].name!))),
                                          Icon(CupertinoIcons.chevron_forward)
                                        ],
                                      ),
Divider()
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),

                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  Container(
                    color: AppColors.ButtonColor.withAlpha(20),

                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Rating",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500),),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                        itemCount: controller.ratingTypes.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                controller.ratingIndex(index);
                              },
                              child: Container(

                                margin: EdgeInsets.only(
                                    left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                    Border.all(color: controller.ratingIndexs != null
                                ? controller.ratingIndexs==index
                                ? AppColors.ButtonColor
                                  : Colors.black
                                  : Colors.black,width: 1),
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child:             RatingBarIndicator(


                                      rating:controller.ratingTypes[index],
                                      itemCount: controller.ratingTypes[index].toInt(),
                                      itemSize: 15,


                                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 5,
                                      ),

                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ),
                  SizedBox(height: 8,),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),

                  Container(
                    color: AppColors.ButtonColor.withAlpha(20),

                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Payment Methods",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500),),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                        itemCount: controller.paymentTypes.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                controller.paymentIndex(index);
                              },
                              child: Container(

                                margin: EdgeInsets.only(
                                    left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                    Border.all(color: controller.paymentSlot != null
                                        ? controller.paymentSlot==index
                                        ? AppColors.ButtonColor
                                        : Colors.black
                                        : Colors.black,width: 1),
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(controller.paymentTypes[index],  style: TextStyle(color: controller.paymentSlot==index?AppColors.ButtonColor:Colors.black),),
                                  ),
                                ),
                              ));
                        }),
                  ),

                ]),
              );
            }

      ),
    ));
  }
  dialogueShowFilter(BuildContext context,List<SubServices> data) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomSubAlertPopup(
          name: "Sub Category",
          message: "",
          buttons: [],
          image: '',
          data: data,
        );
      },
    );
  }
}