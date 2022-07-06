import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:ownervet/model/response/all_categories_response.dart';
import 'package:ownervet/screens/auth/controller/claim_controller.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/custom_text_button.dart';
import 'package:ownervet/utils/custom_text_field.dart';
import 'package:ownervet/utils/validator.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';


class AddAddress extends GetView<ClaimControllerController> {
  var greenBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));
  var blueBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.black),
      borderRadius: BorderRadius.all(Radius.circular(30)));

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: GetBuilder<ClaimControllerController>(
              init: Get.put<ClaimControllerController>(ClaimControllerController()),
              builder: (controller) {
                return SingleChildScrollView(
        child:  SafeArea(
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "Create Account",
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
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: controller.numbers.keys.map((String key) {
                          return new CheckboxListTile(
                            title: new Text(key),
                            value: controller.numbers[key],
                            activeColor: Colors.pink,
                            checkColor: Colors.white,
                            onChanged: ( value) {
                              controller.addWeek(key, value!);


                            },
                          );
                        }).toList(),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 15,right: 15),

                        child: Row(
                          children: [
                            Text("Open Time"),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async{
                           selectTime(context).then((value) => {
                             if(value!=null){
                               controller.openTimeAdd(value!)
                             }
                           });


                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 40, right: 40, top: 15),
                                    child: CustomTextFieldWidget(
                                      fillColor: AppColors.fillColor,
                                      enabled: false,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      controller: controller.openTimeController,
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: ImageIcon(
                                          AssetImage("assets/images/phone.png")),
                                      validator: (val) {
                                        return Validators.validatePhone(val);
                                      },
                                      border:
                                      controller.openTimeController.text.isEmpty
                                          ? greenBorder
                                          : blueBorder,
                                      hintText: "Open Time",
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          children: [
                            Text("Close Time"),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  selectTime(context).then((value) => {
                                    if(value!=null){
                                      controller.closeTimeAdd(value!)
                                    }
                                  });

                                },
                                child: Container(
                                    margin:
                                    EdgeInsets.only(left: 40, right: 40, top: 15),
                                    child: CustomTextFieldWidget(
                                      fillColor: AppColors.fillColor,
                                      enabled: false,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      controller: controller.closeTimeController,
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: ImageIcon(
                                          AssetImage("assets/images/phone.png")),
                                      validator: (val) {
                                        return Validators.validatePhone(val);
                                      },
                                      border: controller.closeTimeController.text.isEmpty
                                          ? greenBorder
                                          : blueBorder,
                                      hintText: "Close Time",
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 40, right: 40, top: 15),
                          child: CustomTextFieldWidget(
                            fillColor: AppColors.fillColor,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: controller.contactController,
                            keyboardType: TextInputType.phone,
                            prefixIcon:
                                ImageIcon(AssetImage("assets/images/phone.png")),
                            validator: (val) {
                              return Validators.validatePhone(val);
                            },
                            border: controller.phoneController.text.isEmpty
                                ? greenBorder
                                : blueBorder,
                            hintText: "Clinic contact number",
                          )),
                      GestureDetector(
                        onTap: () {
                          showPlacePicker(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 40, right: 40, top: 15),
                            child: CustomTextFieldWidget(
                              enabled: false,

                              fillColor: AppColors.fillColor,
                              controller: controller.placeController,
                              maxLines: 1,

                              prefixIcon: ImageIcon(
                                  AssetImage("assets/images/email.png")),
                              border: controller.placeController.text.isEmpty
                                  ? greenBorder
                                  : blueBorder,
                              hintText: "Select Address",
                            )),
                      ),

                      SizedBox(height: 8,),

                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15),

                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Your Category',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 60,
                            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: controller.categories
                                .map((item) =>
                                DropdownMenuItem<Categories>(
                                  value: item,
                                  child: Text(
                                    item.name!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select category.';
                              }
                            },
                            onChanged: ( value) {
                              print(value);

                              controller.saveCategory(value as Categories);
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                             // selectedValue = value.toString();
                            },
                          ),
                        ),


                      Container(
                        margin: EdgeInsets.only(left: 15,right: 15),

                        child: MultiSelectChipField(
                          items: controller.items,
                            showHeader:false,
                          title: Text("Select Payments"),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,),
                          ),
                          selectedChipColor: Colors.blue.withOpacity(0.5),

                          onTap: (values) {
                            //print(values);
                            controller.addPayemnt(values as List<dynamic>);
                            //_selectedAnimals4 = values;
                          },
                        ),
                      ),
           controller.isLoading? Center(child: CircularProgressIndicator(),):           Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 30,right: 30,top: 15),
                        child: CustomTextButton(
                            buttonColor: AppColors.ButtonColor,
                            title:"Save",
                            textColor:Colors.white,
                            onPressed: () {
                              controller.callRegisterApi();
                              //Get.toNamed(AppRoutes.HOME);

                            }

                        ),
                      ),
                    ],
                  ),
                ),
              ));
            }),
      );

  }

  void showPlacePicker(BuildContext context) async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyAMY2WRi3CO4RVgR4eYiQ7nfZf0JqOqBbY",
            )));
    if(result!=null){
      controller.getAddress(result.formattedAddress!,result);
    }

    // Handle the result in your way
    print(result);
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
    return  selectedTime = timeOfDay;
    }
    return null;
  }
}
