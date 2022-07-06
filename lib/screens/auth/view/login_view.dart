

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/auth/controller/login_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:ownervet/utils/validator.dart';

class LoginView extends GetView<LoginController>{

  var greenBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  var blueBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: SingleChildScrollView(
         child: GetBuilder<LoginController>(
       init: Get.put<LoginController>(LoginController()),
    builder: (controller) {
    print("showPassword"+controller.showPassword.toString());
    return Form(
      key: controller.loginFormKey,
      child: Column(
               children: [
SizedBox(height: 8,),
                 Text("Sign In",style: GoogleFonts.montserrat(fontSize: 28,color: Colors.black,),),
                 SizedBox(height: 8,),

                 Container(
                   width: double.infinity,
                     child: Text("Please fill out the form with\nyour login credentials",textAlign:TextAlign.center,style: GoogleFonts.montserrat(fontSize: 14,color: Colors.black,),)),
                 Container(
                     margin: EdgeInsets.only(
                       top: MediaQuery.of(context).size.height * .04,
                     ),
                     child: Image.asset(
                       'assets/images/signin.png',

                       fit: BoxFit.cover,
                     )),
                 Container(
                     margin: EdgeInsets.only(left: 40, right: 40, top: 25),
                     child: CustomTextFieldWidget(
                       fillColor: AppColors.fillColor,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       controller: controller.nameController,
                       prefixIcon: ImageIcon(AssetImage("assets/images/email.png")),
                       validator: (val) {
                         return Validators.validateEmail(val);
                       },
                       border: controller.nameController.text.isEmpty
                           ? greenBorder
                           : blueBorder,
                       hintText: "Name",
                     )),
                 Container(
                     margin: EdgeInsets.only(left: 40, right: 40, top: 25),
                     child: CustomTextFieldWidget(
                       fillColor: AppColors.fillColor,
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       controller: controller.passwordController,
                       prefixIcon: ImageIcon(AssetImage("assets/images/lock.png")),
                       maxLines: 1,
                       obscureText: controller.showPassword,
                       suffixIcon:IconButton(icon:
                       ImageIcon(controller.showPassword?AssetImage("assets/images/hidden.png"):AssetImage("assets/images/eye.png")),onPressed: (){
                         controller.showPasswords(controller.showPassword);
                       },),
                       validator: (val) {
                         return Validators.validatePassword(val);
                       },
                       border: controller.nameController.text.isEmpty
                           ? greenBorder
                           : blueBorder,
                       hintText: "Password",
                     )),
                 SizedBox(height: 8,),

                 Container(
                   width: double.infinity,
                     child: Text("By signing in  you are\nagreeing to all the user terms and services",textAlign:TextAlign.center,style: GoogleFonts.montserrat(fontSize: 8),)),
                 controller.isLoading?Center(child: CircularProgressIndicator(),)    :      Container(
                   width: double.infinity,
                   margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                   child: CustomTextButton(
                       buttonColor: AppColors.ButtonColor,
                       title:"Sign In",
                       textColor:Colors.white,
                       onPressed: () {
controller.callLoginApi();
                       }

                   ),
                 ),
                 Container(
                   width: double.infinity,
                   margin: EdgeInsets.only(left: 20,right: 20,top: 15),
                   child: CustomTextButton(
                       buttonColor:AppColors.lightBlue,
                       title:"Facebook",
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
                       title:"Google",
                       textColor:Colors.white,
                       onPressed: () {
controller.callRegister();
                       }

                   ),
                 ),
             SizedBox(height: 12,),
             RichText(
               text: TextSpan(
                 style: TextStyle(color: Colors.black, fontSize: 20.0),
                 children: <TextSpan>[
                   TextSpan(text: '${'don\'t have an account ?'}',style: TextStyle(fontSize: 14,color: AppColors.text_color)),
                   TextSpan(
                       text: ' Sign up',
                       style: TextStyle(fontSize: 16,color: Colors.red),
                       recognizer: TapGestureRecognizer()
                         ..onTap = () {
                           Get.toNamed(AppRoutes.social);
                         }),

                 ],
               ),
             ),
                 SizedBox(height: 16,)



               ],
             ),
    );}),
         )


     ),
   );
  }

}