

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/screens/addquestionanswer/controller/add_question_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/strings.dart';

class AddQuestionView extends GetView<AddQuestionController>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: PreferredSize(preferredSize: Size.fromHeight(80),
         child: AppUtils().appBar("Question/Answer", "assets/images/cancel.png","assets/images/help.png", endIcon, leadingIcon, )),
     body: SafeArea(
       child: SingleChildScrollView(
         child:  GetBuilder<AddQuestionController>(
   init: Get.put<AddQuestionController>(AddQuestionController()),
    builder: (controller) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    margin: EdgeInsets.only(top:30,right: 15,left: 20),
    child: Text("Ask Question:",style: GoogleFonts.montserrat(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)),
    Container(
    height: 160,
    width: double.infinity,
    margin: EdgeInsets.only(left: 25,right: 25,top: 20),
    child: TextFormField(
      controller: controller.questionController,
    maxLines: 5,
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(
    fillColor: AppColors.fillColor,
    hintText: 'Write your question about your pet...',
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
    child: Text(Strings.addQuestion,textAlign: TextAlign.center,style: GoogleFonts.montserrat(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w400),)),
      controller.isLoading?Center(child: CircularProgressIndicator(),):  Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 30,right: 30,top: 10),
    child: CustomTextButton(
    buttonColor: AppColors.ButtonColor,
    title:"POST",
    textColor:Colors.white,
    onPressed: () {
controller.callCreateQuestion(controller.questionController.text);
    },
    ),
    ),

    ]);
    }))));




  }


  endIcon() {
  }
  leadingIcon(){
    print("back");
    Get.back();

  }
}