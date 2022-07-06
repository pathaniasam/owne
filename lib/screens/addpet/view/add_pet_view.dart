import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/screens/addpet/controller/add_pet_controlller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:ownervet/utils/strings.dart';
import 'package:ownervet/utils/validator.dart';

class AddPetView extends GetView<AddPetController> {
  var greenBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  var blueBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  final List<String> genderItems = [
    'Cat',
    'Dog',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppUtils().appBar(
              "ADD YOUR PET",
              "assets/images/cancel.png",
              "assets/images/help.png",
              endIcon,
              leadingIcon,
            )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<AddPetController>(
                init: Get.put<AddPetController>(AddPetController()),
                builder: (controller) {
                  return Form(
                    key: controller.addPetkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.pickImage();
                              },
                              child: controller.image == null
                                  ? Image.asset(
                                      "assets/images/pet.png",
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0),
                                      child: Image.file(
                                        File(controller.image!.path),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ))),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Enter Pet  Details",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.text_color),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 40, right: 40, top: 25),
                              child: CustomTextFieldWidget(
                                fillColor: AppColors.fillColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.nameController,
                                prefixIcon: ImageIcon(
                                    AssetImage("assets/images/name_pet.png")),
                                validator: (val) {
                                  return Validators.validateEmpty(val);
                                },
                                border: controller.nameController.text.isEmpty
                                    ? greenBorder
                                    : blueBorder,
                                hintText: "Name",
                              )),
                          Container(
                            margin:
                            EdgeInsets.only(left: 40, right: 40, top: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                              color: AppColors.grey.withAlpha(30),

                            ),
                            child: DropdownButtonFormField2(

                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
fillColor: Colors.green,
                                prefixIcon:ImageIcon(
                                    AssetImage("assets/images/species.png")) ,
                                contentPadding: EdgeInsets.zero,
                                errorStyle: TextStyle(fontSize: 10,fontFamily: "Quicksand",fontWeight: FontWeight.w500,color: AppColors.green),

                                errorBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(15)),
                           borderSide: BorderSide(width: 1,color: AppColors.green),
                  ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,

                              hint: const Text(
                                'Select a species',
                                style: TextStyle(fontSize: 14),
                              ),

                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 50,
                              buttonPadding: const EdgeInsets.only(left: 2, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: genderItems
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select gender.';
                                }
                              },

                              onChanged: (value) {
                                //Do something when changing the item if you want.
                                controller.speciesController.text = value.toString();

                              },
                              onSaved: (value) {
                                print(value.toString());
                              },
                            ),
                          ),
                        /*  Container(
                              margin:
                                  EdgeInsets.only(left: 40, right: 40, top: 25),
                              child: CustomTextFieldWidget(
                                fillColor: AppColors.fillColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.speciesController,
                                prefixIcon: ImageIcon(
                                    AssetImage("assets/images/species.png")),
                                validator: (val) {
                                  return Validators.validateEmpty(val);
                                },
                                border:
                                    controller.speciesController.text.isEmpty
                                        ? greenBorder
                                        : blueBorder,
                                hintText: "Species",
                              )),*/
                          Container(
                              margin:
                                  EdgeInsets.only(left: 40, right: 40, top: 25),
                              child: CustomTextFieldWidget(
                                fillColor: AppColors.fillColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.breedController,
                                prefixIcon: ImageIcon(
                                    AssetImage("assets/images/breed.png")),
                                validator: (val) {
                                  return Validators.validateEmpty(val);
                                },
                                border: controller.breedController.text.isEmpty
                                    ? greenBorder
                                    : blueBorder,
                                hintText: "Breed",
                              )),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 40, right: 40, top: 25),
                              child: CustomTextFieldWidget(
                                fillColor: AppColors.fillColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.genderController,
                                prefixIcon: ImageIcon(
                                    AssetImage("assets/images/gender.png")),
                                validator: (val) {
                                  return Validators.validateEmpty(val);
                                },
                                border: controller.genderController.text.isEmpty
                                    ? greenBorder
                                    : blueBorder,
                                hintText: "Gender",
                              )),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              showPicker(context, controller);
                            },
                            child: Container(

                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(30)),
                                margin: EdgeInsets.only(
                                    left: 40, right: 40, top: 25),
                                child: CustomTextFieldWidget(
                                  fillColor: AppColors.fillColor,
                                  enabled: false,
                                  prefixIcon: ImageIcon(
                                      AssetImage("assets/images/dob.png")),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: controller.dateOfBirthController,
                                  validator: (val) {
                                    return Validators.validateEmpty(val);
                                  },
                                  border: controller
                                          .dateOfBirthController.text.isEmpty
                                      ? greenBorder
                                      : blueBorder,

                                  hintText: "Date of birth",
                                )),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 40, right: 40, top: 25),
                              child: CustomTextFieldWidget(
                                fillColor: AppColors.fillColor,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.weightController,
                                prefixIcon: ImageIcon(
                                    AssetImage("assets/images/weights.png")),
                                keyboardType: TextInputType.number,

                                validator: (val) {
                                  return Validators.validateEmpty(val);
                                },
                                inputFormmat: true,
                                border: controller.weightController.text.isEmpty
                                    ? greenBorder
                                    : blueBorder,
                                hintText: "Weight (lbs)",
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            child: Text(
                              Strings.AddPetDetails,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.text_color),
                            ),
                          ),
                          controller.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: CustomTextButton(
                                      buttonColor: AppColors.ButtonColor,
                                      title: "DONE",
                                      textColor: Colors.white,
                                      onPressed: () {
                                        controller.callAddPet();
                                      }),
                                ),
                        ]),
                  );
                }),
          ),
        ));
  }

  endIcon() {}

  leadingIcon() {
    Get.back();
  }

  void showPicker(BuildContext context, AddPetController controller) async {
    AppUtils().selectDate(
      context: context,
      firstDate: DateTime(1950),
      initialDate: DateTime(1980),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 11)),
      onDateSelected: (dateTime) {
        // controller.tecOrderDate.text = dateFormat.format(dateTime);
        // controller.orderDate = controller.tecOrderDate.text;
        controller.setDate(dateTime);
      },
    );
  }
}
