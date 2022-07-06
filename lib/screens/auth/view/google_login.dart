

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/auth/controller/google_controller.dart';
import 'package:ownervet/social/google.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';

class GoogleLogin extends  GetView<GoogleController>{
  var userlogin = GetStorage();

  @override
  Widget build(BuildContext context) {
 return Scaffold(
   body: SafeArea(
     child: SingleChildScrollView(
       child: Column(
         children: [
           SizedBox(height: 16,),
           Text("Create Account",style: GoogleFonts.montserrat(fontSize: 28,color: Colors.black,),),
           SizedBox(height: 8,),

           Container(
               width: double.infinity,
               child: Text("Just one more step",textAlign:TextAlign.center,style: GoogleFonts.montserrat(fontSize: 14,color: Colors.black,),)),
           Container(
               margin: EdgeInsets.only(
                 top: MediaQuery.of(context).size.height * .04,
               ),
               child: Image.asset(
                 'assets/images/social.png',

                 fit: BoxFit.cover,
               )),

           Container(
             width: double.infinity,
             margin: EdgeInsets.only(left: 20,right: 20,top: 15),
             child: CustomTextButton(
                 buttonColor: AppColors.lightBlue,
                 title:"Sign up with Facebook",
                 textColor:Colors.white,
                 onPressed: () {
controller.callFacebookRegister();
                 }

             ),
           ),
           Container(
             width: double.infinity,
             margin: EdgeInsets.only(left: 20,right: 20,top: 15),
             child: CustomTextButton(
                 buttonColor: AppColors.lightRed,
                 title:"Sign up with Google ",
                 textColor:Colors.white,
                 onPressed: () {
                 controller.callRegister();
                 }

             ),
           ),
           Container(
             width: double.infinity,
             margin: EdgeInsets.only(left: 20,right: 20,top: 15),
             child: CustomTextButton(
                 buttonColor: AppColors.ButtonColor,
                 title:"Sign up with Email",
                 textColor:Colors.white,
                 onPressed: () {
Get.toNamed(AppRoutes.createAccount);
                 }

             ),
           ),
           SizedBox(height: 16,),
           RichText(
             text: TextSpan(
               style: TextStyle(color: Colors.black, fontSize: 20.0),
               children: <TextSpan>[
                 TextSpan(text: '${'Already have account ?'}'),
                 TextSpan(
                     text: ' Sign In',
                     style:  TextStyle(color: Colors.red),

                     recognizer: TapGestureRecognizer()
                       ..onTap = () {
                         Get.toNamed(AppRoutes.LOGIN);
                       }),

               ],
             ),
           )


         ],
       ),
     ),
   ),
 );
  }

}