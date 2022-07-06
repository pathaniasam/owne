

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/screens/dashboard/view/book_appointment.dart';
import 'package:ownervet/screens/reviews/controllers/all_review_controller.dart';
import 'package:ownervet/utils/app_utils.dart';

class AllReviewView extends GetView<AllReviewController>{
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: AppUtils().appBar(
        "Reviews",
        "assets/images/cancel.png",
        "assets/images/help.png",
        endIcon,

        leadingIcon,
      )),
  body:  GetBuilder<AllReviewController>(
    init: Get.put<AllReviewController>(AllReviewController()),
    builder: (controller) {
    return SafeArea(
    child: Column(
      children: [
Expanded(child:ListView.builder(
  shrinkWrap: true,
  itemCount: controller.data.length,
    itemBuilder: ( context,int index){
  return Container(
    margin: EdgeInsets.only(
          top: 10,
        left: 10,
        right: 10,
        bottom: 10),
    child:  Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      margin: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10),

      child: Padding(
        padding: const EdgeInsets.only(top:16.0,right: 16.0,bottom: 16,left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius
                        .all(
                        Radius.circular(
                            20)),
                    child: CachedNetworkImage(
                      imageUrl: "" ==
                          null
                          ? "http://via.placeholder.com/350x150"
                          : "http://via.placeholder.com/350x150",
                      height: 30,
                      width: 30,
                      progressIndicatorBuilder: (
                          context, url,
                          downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress
                                  .progress),
                      errorWidget: (context,
                          url, error) =>
                          Icon(Icons.error),
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
                          "sam",
                          style: GoogleFonts
                              .montserrat(
                              fontSize: 14,
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
                RatingBarIndicator(


               rating: controller.data[index].star!.toDouble(),
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
            Container(

              child: Text(
                controller.data![index]
                    .review!,
                style: GoogleFonts
                    .montserrat(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight
                        .w400),),
              margin: EdgeInsets.only(
                  left: 22,
                  right: 15,
                  top: 4),),
            Container(
              width: double.infinity,
              child: Text(AppUtils()
                  .getDateComplete(
                  controller.data[index]
                      .createdAt),
                textAlign: TextAlign.end,
                style: GoogleFonts
                    .montserrat(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight
                        .w400),),
            )

          ],
        ),
      ),
    ),
  );
}))
      ],
    ));
    })
);
  }

}