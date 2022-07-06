

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ownervet/model/response/home_detail_response.dart';
import 'package:ownervet/screens/add_cost/controller/add_cost_controller.dart';
import 'package:ownervet/screens/dashboard/view/book_appointment.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:ownervet/utils/strings.dart';

class AddCostView extends GetView<AddCostController>{
  var greenBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  var blueBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppUtils().appBar(
            "Report Cost",
            "assets/images/cancel.png",
            "assets/images/help.png",
            endIcon,

            leadingIcon,
          )),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 25),
                child: CustomTextFieldWidget(
                  fillColor: AppColors.fillColor,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.priceController,

                  border: controller.priceController.text.isEmpty
                      ? greenBorder
                      : blueBorder,
                  hintText: "${'\$'} Price",


                )),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15,top: 10  ),

              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'Select Your Services',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                items: controller.servicesList!
                    .map((item) =>
                    DropdownMenuItem<Services>(
                      value: item,
                      child: Text(
                        item.service!.name!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select services.';
                  }
                },
                onChanged: ( value) {
                controller.selectServicId(value as Services);

              //    controller.saveCategory(value as ServiceData);
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  // selectedValue = value.toString();
                },
              ),
            ),

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
                    hintText: 'Write your message about the report for the price...',
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
                    controller.addCost();
                  //  controller.callAddPet();
                  }),
            ),
          ],
        ),
      ),
    );
  }

}