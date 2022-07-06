import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/auth/controller/claim_controller.dart';
import 'package:ownervet/screens/auth/controller/create_account_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:ownervet/utils/validator.dart';


class ClaimView extends GetView<ClaimControllerController> {
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
                child: GetBuilder<ClaimControllerController>(
                    init: Get.put<ClaimControllerController>(
                        ClaimControllerController()),
                    builder: (controller) {
                      return SafeArea(
                          child: SingleChildScrollView(
                        child: Form(
                          key: controller.registerFormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Claim Business",
                                style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    color: AppColors.selectedDotColor,
                                    letterSpacing: 2.0),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    "Proffesional",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: AppColors.selectedDotColor,
                                    ),
                                  )),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: controller.image == null
                                      ? Image.asset(
                                          "assets/images/dp_placeholder.png",
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60.0),
                                          child: Image.file(
                                            File(controller.image!.path),
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ))),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 40, right: 40, top: 25),
                                  child: CustomTextFieldWidget(
                                    fillColor: AppColors.fillColor,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: controller.nameController,
                                    prefixIcon: ImageIcon(AssetImage(
                                        "assets/images/profile.png")),
                                    validator: (val) {
                                      return Validators.validateUsername(val);
                                    },
                                    border:
                                        controller.nameController.text.isEmpty
                                            ? greenBorder
                                            : blueBorder,
                                    hintText: "Name",
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 40, right: 40, top: 15),
                                  child: CustomTextFieldWidget(
                                    fillColor: AppColors.fillColor,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: controller.emailController,
                                    prefixIcon: ImageIcon(
                                        AssetImage("assets/images/email.png")),
                                    validator: (val) {
                                      return Validators.validateEmail(val);
                                    },
                                    border:
                                        controller.emailController.text.isEmpty
                                            ? greenBorder
                                            : blueBorder,
                                    hintText: "Email",
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 40, right: 40, top: 15),
                                  child: CustomTextFieldWidget(
                                    fillColor: AppColors.fillColor,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: ImageIcon(
                                        AssetImage("assets/images/phone.png")),
                                    validator: (val) {
                                      return Validators.validatePhone(val);
                                    },
                                    border:
                                        controller.phoneController.text.isEmpty
                                            ? greenBorder
                                            : blueBorder,
                                    hintText: "Phone Number",
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 40, right: 40, top: 15),
                                  child: CustomTextFieldWidget(
                                    fillColor: AppColors.fillColor,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: controller.passwordController,
                                    prefixIcon: ImageIcon(
                                        AssetImage("assets/images/lock.png")),
                                    validator: (val) {
                                      return Validators.validatePassword(val);
                                    },
                                    maxLines: 1,
                                    obscureText: controller.showPassword,//This will obscure text dynamically

                                    suffixIcon:IconButton(icon:
                                    ImageIcon(controller.showPassword?AssetImage("assets/images/hidden.png"):AssetImage("assets/images/eye.png")),onPressed: (){
                                      controller.showPasswords(controller.showPassword);
                                    },),
                                    border: controller
                                            .passwordController.text.isEmpty
                                        ? greenBorder
                                        : blueBorder,
                                    hintText: "Password",
                                  )),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    "By signing in  you are\nagreeing to all the user terms and services",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(fontSize: 8),
                                  )),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 30, right: 30, top: 15),
                                child: CustomTextButton(
                                    buttonColor: AppColors.ButtonColor,
                                    title: "Save",
                                    textColor: Colors.white,
                                    onPressed: () {
                                      controller.callRegister();
                                      //Get.toNamed(AppRoutes.HOME);
                                    }),
                              ),
                              SizedBox(
                                height: 16,
                              ),

                            ],
                          ),
                        ),
                      ));
                    }))));
  }
}
