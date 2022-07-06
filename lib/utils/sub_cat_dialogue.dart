import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/model/response/all_services.dart';
import 'package:ownervet/screens/search/controller/search_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';


class CustomSubAlertPopup extends GetView<SearchController> {
  final String message, image, name;
  final List<SubServices> data;

  final List<CustomTextButton> buttons;

  CustomSubAlertPopup(
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
                                Text(""),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          color: AppColors.ButtonColor.withAlpha(20),

                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sub Services:",style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w500),),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black,
                        ),
                        Expanded(

                          child: ListView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      controller.categoryIndex(data[index].id!);
                                      controller.filterApiCall();
Navigator.pop(context);
Navigator.pop(context);
                                    },
                                    child: Container(

                                      margin: EdgeInsets.only(
                                          left: 10, right: 10),

                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(data[index].name!),
                                            )),
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



/*  dialogueShowFilter(BuildContext context,) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomAlertPopup(
          name: "Filter Search",
          message: "",
          buttons: [],
          image: '',
          data: controller.serviceData,
        );
      },
    );
  }*/



