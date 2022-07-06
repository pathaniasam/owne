

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ownervet/model/response/dashboard_response.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/screens/search/controller/search_controller.dart';
import 'package:ownervet/screens/search/view/end_drawer.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_alert_dialogue.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

class SearchFilter extends GetView<SearchController>{
  var greenBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.fillColor),
      borderRadius: BorderRadius.all(Radius.circular(12)));
  var blueBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.fillColor),
      borderRadius: BorderRadius.all(Radius.circular(12)));
  @override
  Widget build(BuildContext context) {
  return GetBuilder<SearchController>(
      init:
      Get.put<SearchController>(SearchController()),
      builder: (controller) {
        //controller.onInit();
        return Scaffold(
    key: controller.scaffoldkey,
    endDrawer: Container(
      width: MediaQuery.of(context).size.width*0.85,
      child: EndDrawer(name: "Filter",data: controller.serviceData, message: '', image: '', buttons: [],),
    ),
    body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    showPlacePicker(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 10, top: 15, bottom: 10),
                      child: CustomTextFieldWidget(
                        enabled: false,
                        fillColor: AppColors.fillColor,

                        autovalidateMode: AutovalidateMode
                            .onUserInteraction,
                        prefixIcon: Icon(CupertinoIcons.location),
                        suffixIcon: Image.asset(
                          "assets/images/directions.png",
                        ),

                        maxLength: 5,

                        border: greenBorder,

                        hintText: "Enter Location",
                      )),
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 10, top: 15, bottom: 10),
                child: ElevatedButton(
                  style: ButtonStyle(

                    padding: MaterialStateProperty.all<
                        EdgeInsetsGeometry>(EdgeInsets.all(12.0)),
                    backgroundColor: MaterialStateProperty.resolveWith<
                        Color>((states) {
                      return AppColors.ButtonColor;
                    }),

                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    overlayColor: MaterialStateProperty.resolveWith<
                        Color>((states) {
                      return AppColors.ButtonColor;
                    }),

                    //For text color,
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    //For border
                    side: MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return BorderSide(
                            color: AppColors.ButtonColor,
                            width: 2,
                          );
                        else
                          return BorderSide(
                              color: AppColors.ButtonColor, width: 2);
                      },
                    ),
                  ),
                  onPressed: () {
                   Get.back();
                  }, child: Text("MAP", style: TextStyle(
                    color: Colors.white),),
                ),
              ),
            ],
          ),
SizedBox(
  height: 40,
  child: ListView(
  scrollDirection: Axis.horizontal,

 children: [
   SizedBox(width: 12,),
   GestureDetector(
     onTap: (){
       controller.openDrawer();
     },
     child: Container(

       child: Padding(
         padding: const EdgeInsets.all(6.0),
         child: Icon(CupertinoIcons.slider_horizontal_3,size: 25,)
       ),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
         border: Border.all(color: Colors.black)
       ),

     ),
   ),
   SizedBox(width: 4,),
   Container(
     height: 32,
     width:110,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(8)),
       color: AppColors.greys.withAlpha(70),

     ),
     child: DropdownButtonFormField2(
       decoration: InputDecoration(
         //Add isDense true and zero Padding.
         //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
         isDense: true,
         fillColor: Colors.green,
         enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide(
               color: AppColors.grey,
               width: 1.0,
             )),
         contentPadding: EdgeInsets.only(left: 5),
         errorStyle: TextStyle(
             fontSize: 10,
             fontFamily: "Quicksand",
             fontWeight: FontWeight.w500,
             color: AppColors.lightgrey),
         focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide(color:AppColors.grey, width: 1.0)),
         errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(8)),
           borderSide:
           BorderSide(width: 1, color: AppColors.grey),
         ),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8),
         ),
         //Add more decoration as you want here
         //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
       ),
       isExpanded: true,
       hint: controller.filterController.text.isNotEmpty?Text(
         controller.filterController.text,
         style: TextStyle(fontSize: 14),
       ): Text(
         'Sort By',
         style: TextStyle(fontSize: 12),
       ),
       icon: const Icon(
         CupertinoIcons.chevron_down,
         size: 18,
         color: Colors.black,
       ),
       iconSize: 30,
       buttonHeight:    62,
       buttonWidth: 60,
       buttonPadding:
       const EdgeInsets.only(left: 2, right: 10),
       dropdownDecoration: BoxDecoration(
         borderRadius: BorderRadius.circular(2),
       ),
       items: controller.filterList
           .map((item) => DropdownMenuItem<String>(
         value: item,
         child: Text(
           item.toString(),
           style: const TextStyle(
             fontSize: 12,
           ),
         ),
       ))
           .toList(),
       validator: (value) {
         if (value == null) {
           return 'Please currency.';
         }
       },
       onChanged: (value) {
         //Do something when changing the item if you want.
        controller.filterPrice(value as String);
       },
       onSaved: (value) {
         print(value.toString());
       },
     ),
   ),
   SizedBox(width: 4,),
   Container(
     height: 32,
     width:110,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.all(Radius.circular(8)),
       color: AppColors.greys.withAlpha(70),

     ),
     child: DropdownButtonFormField2(
       decoration: InputDecoration(
         //Add isDense true and zero Padding.
         //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
         isDense: true,
         fillColor: Colors.green,
         enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide(
               color: AppColors.grey,
               width: 1.0,
             )),
         contentPadding: EdgeInsets.only(left: 5),
         errorStyle: TextStyle(
             fontSize: 10,
             fontFamily: "Quicksand",
             fontWeight: FontWeight.w500,
             color: AppColors.lightgrey),
         focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide(color:AppColors.grey, width: 1.0)),
         errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(8)),
           borderSide:
           BorderSide(width: 1, color: AppColors.grey),
         ),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8),
         ),
         //Add more decoration as you want here
         //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
       ),
       isExpanded: true,
       hint: controller.filterController.text.isNotEmpty?Text(
         controller.filterController.text,
         style: TextStyle(fontSize: 14),
       ): Text(
         'Pet',
         style: TextStyle(fontSize: 12),
       ),
       icon: const Icon(
         CupertinoIcons.chevron_down,
         size: 18,
         color: Colors.black,
       ),
       iconSize: 30,
       buttonHeight:    62,
       buttonWidth: 60,
       buttonPadding:
       const EdgeInsets.only(left: 2, right: 10),
       dropdownDecoration: BoxDecoration(
         borderRadius: BorderRadius.circular(2),
       ),
       items: controller.genderItems
           .map((item) => DropdownMenuItem<String>(
         value: item,
         child: Text(
           item.toString(),
           style: const TextStyle(
             fontSize: 12,
           ),
         ),
       ))
           .toList(),
       validator: (value) {
         if (value == null) {
           return 'Please currency.';
         }
       },
       onChanged: (value) {
         //Do something when changing the item if you want.
          controller.genderSearch(value as String);
       },
       onSaved: (value) {
         print(value.toString());
       },
     ),
   ),
   SizedBox(width: 4,),



 ],
),),
          Expanded(child: ListView.builder(
            itemCount: controller.data.length,
                     itemBuilder: (context, index){
                       return  detailsWidget(controller.data[index]);
                     }))

        ])));});}





  void showPlacePicker(BuildContext context) async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyAMY2WRi3CO4RVgR4eYiQ7nfZf0JqOqBbY",
        )));
    if(result!=null){
      controller.getAddress(result.formattedAddress!,result);
    }

    // Handle the result in your way
    print(result);
  }

  Widget detailsWidget(HomeData result) {
    return InkWell(
      onTap: (){
        DashBoardDetailController response=Get.put<DashBoardDetailController>(DashBoardDetailController());
        response.id=result.id.toString();
        print(result.id.toString()+"MyId");
        Get.toNamed(AppRoutes.detail_home);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10,top: 10),

        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          child: Container(
            child: Container(
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    child:CachedNetworkImage(
                                      imageUrl:result.profileImage==null?"":result.profileImage!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>Image.asset("assets/images/rectangle.png"),
                                      fit: BoxFit.cover,
                                    ),),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 4,right: 4),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(result.name!,
                                                  maxLines: 1,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(CupertinoIcons.location,size: 12,),
                                                  Text(result.distance!.toStringAsFixed(2)+" KM", style: GoogleFonts.montserrat(
                                                      fontSize: 7, color: Colors.black,fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(result.address!, style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.black,fontWeight: FontWeight.w400),)  ,
                                          SizedBox(height: 5,),

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
                                  SizedBox(width: 4,),
                                  Text("${ DateFormat.jm().format(
                                      DateFormat("hh:mm").parse(result.openTime!))}${"- "}${DateFormat.jm().format(
                                      DateFormat("hh:mm").parse(result.closeTime!))}",style: GoogleFonts.montserrat(
                                      fontSize: 11, color: Colors.black,fontWeight: FontWeight.w500),),
                                  Spacer(),
                                  RatingBarIndicator(


                                    rating:result.rating==null?2: result.rating!.toDouble(),
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


                              SizedBox(height: 8,),

                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Column(
                          children: [

                            Text("${result.price.toString()}${result.currency.toString()=="USD"?" \$":" CAD"}",style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w500),),
                            Text(result.price_type.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w300),),

                          ],
                        )
                      ],
                    ),
                  ),
SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}