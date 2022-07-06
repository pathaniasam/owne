

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/deals/controller/appointment_detail_controller.dart';
import 'package:ownervet/deals/controller/deals_controller.dart';
import 'package:ownervet/drawer/view/drawer_screen.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/strings.dart';

class DealsView extends GetView<DealsController>{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DealsController>(
        init: Get.put<DealsController>(
            DealsController()),
        builder: (controller) {
          //controller.onInit();
          return  Scaffold(
        drawer: Container(
            width: MediaQuery.of(context).size.width * 0.85,//20.0,,
            child: DrawerMenu()),
      key:controller.scaffoldkey ,
      appBar: PreferredSize(preferredSize: Size.fromHeight(80),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.openDrawer();
                  },
                    child: Image.asset("assets/images/menu.png")),
                controller.userLogin.read(GetConstant.image)!=null? GestureDetector(
                  onTap: (){
                    Get.offNamed(AppRoutes.myprofile);

                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),

                    child: CachedNetworkImage(
                      imageUrl: controller.userLogin.read(GetConstant.image),
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
                ):         Image.asset("assets/images/dog.png")
              ],
            ),
          ),
        ),


      ),
      body:SafeArea(
    child: Container(
    margin: EdgeInsets.only(left: 10,right: 10),
    child: Column(
    children: [
    Container(
    margin: EdgeInsets.only(top: 18,left: 10,right: 10),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("Deals",style: GoogleFonts.montserrat(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.black),),

     Spacer(), /*Container(
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
            'All',
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
            controller.filtersList(value as String);
          },
          onSaved: (value) {
            print(value.toString());
          },
        ),
      ),*/
    ],
    ),
    ),
    SizedBox(height: 18,),
    Container(
    margin: EdgeInsets.only(left: 12,right: 12),

    width: double.infinity,
    child: Text(Strings.addDeals,style: TextStyle(fontSize:14),)),
      SizedBox(height: 18,),

      Expanded(child: ListView.builder(
    itemCount: controller.data.length,
    shrinkWrap: true,
    itemBuilder: (context,index)
    {
    return Container(
      margin: EdgeInsets.only(top: 10),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),

      elevation: 5,
    child: Container(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
      height: 40,
      width: 40,
        decoration: BoxDecoration(
            color: Colors.blue.withAlpha(40),
            borderRadius: BorderRadius.circular(15)
        ),
      margin: EdgeInsets.only(left: 8,top: 10),
      child:CachedNetworkImage(
      imageUrl: controller.data[index].profileImage==null?"": controller.data[index].profileImage!,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
      CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Image.asset("assets/images/rectangle.png"),
      fit: BoxFit.cover,
      ),),
      SizedBox(width: 8,),
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Text(controller.data[index].name!, style: GoogleFonts.montserrat(
              fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),),
              Text(controller.data[index].address!, style: GoogleFonts.montserrat(
              fontSize: 12, color: Colors.black,fontWeight: FontWeight.w400),),

              ],
              ),
            ),
            Container(

              child: GestureDetector(
                onTap: (){
                  DashBoardDetailController response=Get.put<DashBoardDetailController>(DashBoardDetailController());
                  response.id= controller.data[index].professional_id.toString();
                  Get.toNamed(AppRoutes.detail_home);
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Book Now",style: TextStyle(color: AppColors.ButtonColor,fontSize: 12,fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      ],
      ),
      SizedBox(height: 5,),
      Container(
      margin: EdgeInsets.only(left: 8,right: 8),
      child: Text(controller.data[index].description!,style: GoogleFonts.montserrat(color: AppColors.red,fontSize: 12,fontWeight: FontWeight.w500,),)),
      Container(
      margin: EdgeInsets.only(left: 8,right: 8,top: 6 ),

      child: Row(
      children: [
      Text("Code : ",style: GoogleFonts.montserrat(color: Colors.black,fontSize: 12,fontWeight: FontWeight.normal),),
      Text(controller.data[index].promocode!,style: GoogleFonts.montserrat(color: AppColors.ButtonColor,fontWeight: FontWeight.w500,fontSize: 12,))
      ],
      ),
      ),
      Container(
      margin: EdgeInsets.only(left: 8,right: 8,bottom: 10,top: 8),

      child: Row(
      children: [
      Icon(CupertinoIcons.time,size: 10,),
      Text(" Exp : "+spiltExpiry(controller.data[index].expiry!),style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500),),
      Spacer(),
   /* RatingBar.builder(


      initialRating: 5,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 10,

      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
      size: 5,
      ),
      onRatingUpdate: (rating) {
      print(rating);
      },
      ),*/
      Icon(CupertinoIcons.location,size: 15,),
      Text("${controller.data[index].distance!.toStringAsFixed(2)} km",style: GoogleFonts.montserrat(
      fontSize: 10, color: Colors.black,fontWeight: FontWeight.w400),)

      ],
      ),
      )
      ],
      ),
    ),
    ),
    ),
    );

    }))

    ],
    ),
    ),
        ));
    });
  }


  String spiltExpiry(String time){
    List<String> dateParts = time.split("T");
    return dateParts[0];
  }

  }

