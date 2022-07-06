import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/model/response/all_services.dart';
import 'package:ownervet/screens/search/controller/search_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/sub_cat_dialogue.dart';


class CustomAlertPopup extends GetView<SearchController> {
  final String message, image, name;
  final List<ServicesData> data;

  final List<CustomTextButton> buttons;

  CustomAlertPopup(
      {required this.name,
        required this.message,
        required this.buttons,
        required this.image,
        required this.data});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init:
      Get.put<SearchController>(SearchController()),
      builder: (controller) {
        //controller.onInit();
        return Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.selectedDotColor),
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
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

                            },
                              child: Text("Done",style:GoogleFonts.montserrat(color: Colors.white),)),

                        ],
                      ),
                    ),
                  ),
                 Container(
                   width: double.infinity,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("Sort By:",style: GoogleFonts.montserrat(fontSize: 14),),
                   ),
                 ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Pet/Type:",style: GoogleFonts.montserrat(fontSize: 14),),
                    ),
                  ),
                  Divider(),
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
                                  color: controller.selectSlot != null
                                      ? controller.selectSlot == index
                                      ? AppColors.ButtonColor
                                      : Colors.white
                                      : Colors.white,
                                  border:
                                  Border.all(color: Colors.black),
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(controller.genderItems[index]),
                            ),
                          ));
                        }),
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Services:",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w400),),
                    ),
                  ),
                  Divider(),
                  Expanded(

                    child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                          if(data[index].subServices!=null){
                            dialogueShowFilter(context,data[index].subServices!);
                          }else{
//controller.filterApiCall(data[index].id.toString());
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

                ]),
              )),
        ));
  }
    );
}}



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



