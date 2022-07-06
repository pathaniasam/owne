

import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/auth/controller/create_account_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:ownervet/utils/validator.dart';

class CreateAccountView extends  GetView<CreateAccountController>{
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
          child:  GetBuilder<CreateAccountController>(
        init: Get.put<CreateAccountController>(CreateAccountController()),
    builder: (controller) {
          print("showPassword"+controller.showPassword.toString());
    return Form(
    key: controller.registerFormKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
    children: [
    SizedBox(height: 16,),
    Text("Create Account",style: GoogleFonts.montserrat(fontSize: 28,color: Colors.black,),),
    SizedBox(height: 8,),

    Container(
    width: double.infinity,
    child: Text("Pet parents",textAlign:TextAlign.center,style: GoogleFonts.montserrat(fontSize: 14,color: Colors.black,),)),
    GestureDetector(
      onTap: (){
        controller.pickImage();
      },
        child:controller.image==null? Image.asset("assets/images/dp_placeholder.png",height: 120,width:120,fit: BoxFit.cover,):ClipRRect(
            borderRadius: BorderRadius.circular(60.0),


            child: Image.file(File(controller.image!.path),height: 120,width: 120,fit: BoxFit.cover,))),

    Container(
    margin: EdgeInsets.only(left: 40, right: 40, top: 25),
    child: CustomTextFieldWidget(
    fillColor: AppColors.fillColor,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller.nameController,
    prefixIcon: ImageIcon(AssetImage("assets/images/person.png")),
    validator: (val) {
    return Validators.validateUsername(val);
    },
    border: controller.nameController.text.isEmpty
    ? greenBorder
        : blueBorder,
    hintText: "Name",
    )),

    Container(
    margin: EdgeInsets.only(left: 40, right: 40, top: 15),
    child: CustomTextFieldWidget(
    fillColor: AppColors.fillColor,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller.emailController,
    prefixIcon: ImageIcon(AssetImage("assets/images/email.png")),
    validator: (val) {
    return Validators.validateEmail(val);
    },
    border: controller.emailController.text.isEmpty
    ? greenBorder
        : blueBorder,
    hintText: "Email",
    )),
      /*   Expanded(
          flex: 3,

          child: Container(
            height: 47,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20)

          ),
            child: CountryCodePicker(
              padding: EdgeInsets.all(2),
              onChanged: (value){
                if(value.dialCode!=null)
                controller.updateCountryCode(value.dialCode.toString());

                  print("code"+value.dialCode .toString());

              },
              onInit:(value){
                print("codes"+value.toString());

              },
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'CA',
              favorite: ['+1','CA'],
              // optional. Shows only country name and flag
              showCountryOnly: false,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: false,


              // optional. aligns the flag and the Text left
              alignLeft: false,
              textStyle: TextStyle(fontSize: 14,color: Colors.black),




            ),
          ),
        ),
        SizedBox(width: 2,),*/
    Container(
    margin: EdgeInsets.only(left: 40, right: 40, top: 15),
    child: CustomTextFieldWidget(
    fillColor: AppColors.fillColor,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller.phoneController,
    keyboardType: TextInputType.phone,
    prefixIcon: ImageIcon(AssetImage("assets/images/phone.png")),
    validator: (val) {
    return Validators.validateEmpty(val);
    },
    border: controller.phoneController.text.isEmpty
    ? greenBorder
        : blueBorder,
    hintText: "Phone Number",
    )),

    Container(
    margin: EdgeInsets.only(left: 40, right: 40, top: 15),
    child: CustomTextFieldWidget(
    fillColor: AppColors.fillColor,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller.passwordController,
      obscureText: controller.showPassword,//This will obscure text dynamically

     maxLines: 1,
        suffixIcon:IconButton(icon:
        ImageIcon(controller.showPassword?AssetImage("assets/images/hidden.png"):AssetImage("assets/images/eye.png")),onPressed: (){
          controller.showPasswords(controller.showPassword);
        },),
    prefixIcon: ImageIcon(AssetImage("assets/images/lock.png")),

    validator: (val) {
    return Validators.validatePassword(val);
    },
    border: controller.passwordController.text.isEmpty
    ? greenBorder
        : blueBorder,
    hintText: "Password",
    )),
    SizedBox(height: 8,),
    Container(
    width: double.infinity,
    child: Text("By signing in  you are\nagreeing to all the user terms and services",textAlign:TextAlign.center,style: GoogleFonts.montserrat(fontSize: 12),)),
  controller.isLoading?Center(child: CircularProgressIndicator(),):  Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 20,right: 20,top: 15),
    child: CustomTextButton(
    buttonColor: AppColors.ButtonColor,
    title:"Go",
    textColor:Colors.white,
    onPressed: () {
   // Get.toNamed(AppRoutes.HOME);
      controller.callRegister();

    }

    ),
    ),
    SizedBox(height: 12,),
    RichText(
    text: TextSpan(
    style: TextStyle(color: Colors.black, fontSize: 20.0),
    children: <TextSpan>[
    TextSpan(text: '${'Already have account ?'}',style: TextStyle(fontSize: 14,color: AppColors.text_color)),
    TextSpan(
    text: ' Sign In',
    style: TextStyle(fontSize: 16,color: Colors.red),

    recognizer: TapGestureRecognizer()
    ..onTap = () {
    Get.toNamed(AppRoutes.LOGIN);
    }),

    ],
    ),
    )
    ],


    ),
    );
    }
        ),
      ),
    ));
  }

}