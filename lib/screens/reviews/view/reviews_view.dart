import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/screens/reviews/controllers/reviews_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/strings.dart';

class ReviewsView extends GetView<ReviewsController>{
  @override
  Widget build(BuildContext context) {
 return Scaffold(
   appBar: PreferredSize(
       preferredSize: Size.fromHeight(80),
       child: AppUtils().appBar(
         "Write Your Review",
         "assets/images/cancel.png",
         "assets/images/help.png",
         endIcon,

         leadingIcon,
       )),
   body:  GetBuilder<ReviewsController>(
       init: Get.put<ReviewsController>(ReviewsController()),
       builder: (controller) {
    return SafeArea(
    child:
    SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 18,right: 18),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        controller.imageUrl==null || controller.imageUrl!.isEmpty?Center(child: Image.asset("assets/images/placeholder.png"),) : Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            height: 80,
          width: 80,
          imageUrl: controller.imageUrl!,

          progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
          ),
        ),
        ),
        SizedBox(height: 10,),
        Container(
          child: Center(child: Text("sam",style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
        ),
        Container(

        child: Text("Rating:",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),)),
        SizedBox(height: 10,),

        RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
        print(rating);
        controller.setRating(rating);
        },
        ),
          SizedBox(height: 10,),


          Container(

              child: Text("Review:",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),)),
          SizedBox(height: 8,),
          Container(
              height: 160,
              width: double.infinity,
              margin: EdgeInsets.only(left: 25,right: 25,top: 20),
              child: TextFormField(
                controller: controller.reviewController,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  fillColor: AppColors.fillColor,
                  hintText: 'Write your reviews...',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black,width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),

                      )),
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black,width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),

                    ),
                  ),
                ),
              )
          ),

          Container(
              width: double.infinity,
              child: Text(Strings.addCost,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,)),

          controller.isLoading?Center(child: CircularProgressIndicator(),):      Container(
            width: double.infinity,
            margin: EdgeInsets.only(
                left: 20, right: 20, top: 15),
            child: CustomTextButton(
                buttonColor: AppColors.ButtonColor,
                title: "POST",
                textColor: Colors.white,
                onPressed: () {
                  controller.addReview();
                  //  controller.callAddPet();
                }),
          ),
        ],
        ),
      ),
    ),
    );
    }));
  }


  endIcon() {
  }
  leadingIcon(){
Get.back();
  }
}