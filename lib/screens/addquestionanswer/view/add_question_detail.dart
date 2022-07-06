

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/addquestionanswer/controller/question_detail_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:share_plus/share_plus.dart';

class AddQuestionDetail extends GetView<AddQuestionDetailController>{
  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      Navigator.pop(context);
      return true; // return true if the route to be popped
    }
    return WillPopScope(
      onWillPop:_willPopCallback,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(80),
            child: AppUtils().appBar("Question/Answer", "assets/images/cancel.png","assets/images/help.png", endIcon, leadingIcon, )),

        body: SafeArea(
          child:
      GetBuilder<AddQuestionDetailController>(
      init: Get.put<AddQuestionDetailController>(AddQuestionDetailController()),
      builder: (controller) {
      return Stack(
        children: [
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                      child: Text("Question",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),)),
              Container(
                margin: EdgeInsets.only(top: 10,left: 30,),
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            child:ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: "http://via.placeholder.com/350x150",
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(

                                  child: Text(controller.questionData!.user!.name!,style: GoogleFonts.montserrat(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w400),),
                                  margin: EdgeInsets.only(left: 4),),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(AppUtils().getDateComplete(controller.questionData!.createdAt),style: GoogleFonts.montserrat(fontSize: 8,color: Colors.black,fontWeight: FontWeight.w400),)
                        ],
                      ),
                      Container(

                        child: Text(controller.questionData!.question!,style: GoogleFonts.montserrat(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w500),),
                        margin: EdgeInsets.only(left: 17,right: 15,top: 8),),

                    ],
                  ),
                ),
              ),
                  Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 15),
                      child: Text("Answer",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),)),
                  Expanded(
                    child: NotificationListener(
                      onNotification: (t){
                        if (t is ScrollEndNotification) {
                          if((controller.scrollcontroller.position.pixels == controller.scrollcontroller.position.maxScrollExtent) && (controller.response!.pageInfo!.hasMoreData??false)){
                            print("true");
                          }else{
                            print("false");

                          }
                        }else{
                          print("falsesss");

                        }
                        return true;
                      },
                      child: ListView.builder(
                          itemCount:controller.data.length,
                          shrinkWrap: true,
                          controller: controller.scrollcontroller,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.detailQuestion);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10,left: 20,right: 10),
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            child:ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              child: CachedNetworkImage(
                                                imageUrl: controller.data[index].user!.profileImage==null?"http://via.placeholder.com/350x150":controller.data[index].user!.profileImage!,
                                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                    CircularProgressIndicator(value: downloadProgress.progress),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(

                                                  child: Text(controller.data[index].user!.name!,style: GoogleFonts.montserrat(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w500),),
                                                  margin: EdgeInsets.only(left: 4),),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Text(AppUtils().getDateComplete(controller.data[index].createdAt),style: GoogleFonts.montserrat(fontSize: 8,color: Colors.black,fontWeight: FontWeight.w400),)
                                        ],
                                      ),
                                      Container(

                                        child: Text(controller.data[index].answer!,style: GoogleFonts.montserrat(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400),),
                                        margin: EdgeInsets.only(left: 17,right: 15,top: 8),),
                                      Container(
                                        margin: EdgeInsets.only(left: 15,top: 8),
                                        child: Row(
                                          children: [
                                      /*      Image.asset("assets/images/answer.png"),
                                            SizedBox(width: 4,),
                                            Text("Answer",style: GoogleFonts.montserrat(color: AppColors.green,fontSize: 12),),*/

                                            SizedBox(width: 4,),

                                            Image.asset("assets/images/share.png"),
                                            SizedBox(width: 4,),
                                            GestureDetector(
                                              onTap: (){
                                                Share.share(controller.data[index].answer!);

                                              },
                                                child: Text("Share",style: GoogleFonts.montserrat(color: AppColors.green,fontSize: 12),)),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  buildInput(context)
                ]),
        ],
      );

          }))

      ),
    );
  }
  endIcon(){

  }

  leadingIcon(){
    Get.back();

  }


  Widget buildInput(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image



          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                 // onSendMessage(textEditingController.text, TypeMessage.text);
                },
                
                style: TextStyle(color:Colors.black, fontSize: 15),
                controller: controller.replyAnswer,
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/images/keyboard.png"),
                  border: InputBorder.none,

                  hintText: 'Type your answer here ...',

                  hintStyle: TextStyle(color: Colors.grey),
                  
                ),

              ),
            ),
          ),

          // Button send message
          Material(

            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Image.asset("assets/images/send.png"),
                onPressed: (){
controller.callReplyAnswer(controller.replyAnswer.text);
FocusScope.of(context).requestFocus(FocusNode());

                },
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color:Colors.green)),
    ));
  }
}