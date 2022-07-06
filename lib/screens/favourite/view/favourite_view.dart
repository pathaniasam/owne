

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/screens/favourite/controller/favourite_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';

import '../../../routes/app_routes.dart';

class FavouriteView extends GetView<FavouriteController>{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppUtils().appBar(
            "Favorites",
            "assets/images/cancel.png",
            "assets/images/help.png",
            endIcon,
            leadingIcon,
          )),
      body:GetBuilder<FavouriteController>(
          init: Get.put<FavouriteController>(FavouriteController()),
          builder: (controller) {
    return SafeArea(
    child:Container(
    child: Column(
    children: [
Expanded(child:ListView.builder(
  itemCount: controller.professionals.length,
    itemBuilder: (context,index)
    {
      return GestureDetector(
        onTap: (){
          DashBoardDetailController response=Get.put<DashBoardDetailController>(DashBoardDetailController());
          response.id=controller.professionals[index].id.toString();
          Get.toNamed(AppRoutes.detail_home);
        },
        child: Container(
          child: Container(
            margin: EdgeInsets.only(left: 25,right: 25,top: 10),
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
                                    imageUrl:controller.professionals[index].profileImage!,
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
                                        Text(controller.professionals[index].name!, style: GoogleFonts.montserrat(
                                            fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),),
                                        Text(controller.professionals[index].address!, style: GoogleFonts.montserrat(
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
                                    DateFormat("hh:mm").parse(controller.professionals[index].openTime!))}${"- "}${DateFormat.jm().format(
                                    DateFormat("hh:mm").parse(controller.professionals[index].closeTime!))}",style: GoogleFonts.montserrat(
                                    fontSize: 11, color: Colors.black,fontWeight: FontWeight.w500),),
Spacer(),
                                RatingBarIndicator(


                                  rating:controller.professionals[index].rating==null?2: controller.professionals[index].rating!.toDouble(),
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
                       IconButton(onPressed: (){
controller.callFavouriteApi(controller.professionals[index].id);
controller.updateFavourite(index);
                       }, icon: Icon(CupertinoIcons.heart_solid,color: Colors.red,))
                    ],
                  ),
                ),
                Divider(color: Colors.black,thickness: 1.1,)

              ],
            ),
          ),
        ),
      );

}))
    ],
    ),
    ) ,
    );
    }));
  }


  endIcon() {
  }

  leadingIcon() {
    Get.back();
  }
}