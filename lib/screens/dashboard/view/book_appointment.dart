import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ownervet/model/response/all_pet_response.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookAppointment extends GetView<DashBoardDetailController> {
  var userlogin=GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardDetailController>(
        init:
        Get.put<DashBoardDetailController>(DashBoardDetailController()),
        builder: (controller) {
          //controller.onInit();
          return Scaffold(
        bottomNavigationBar: BottomAppBar(

          child:         Container(
            decoration: BoxDecoration(
                color: AppColors.lightgrey.withOpacity(0.8),

                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),)
            ),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(
                    child: Row(
                      children: [

                        controller.isCouponApplied? Text("${controller.currency=="USD"?" \$":" CAD "}${controller.grandTotal.toString()}",
                            style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.grey,decoration: TextDecoration.lineThrough,)):
                        Text("${controller.currency=="USD"?" \$":" CAD "}${controller.grandTotal.toString()}",
                            style: GoogleFonts.montserrat(
                              fontSize: 18, color: Colors.black,  )),

                        controller.isCouponApplied
                            ? Text("${controller.currency=="USD"?" \$":" CAD "}${controller.total.toString()}",
                            style: GoogleFonts.montserrat(
                                fontSize: 18, color: Colors.black))
                            :SizedBox.shrink(),

                      ],
                    ),
                  ),
                    ElevatedButton(
                        child: Text("Book Now".toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontSize: 14, color: Colors.white)),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                AppColors.ButtonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: AppColors.ButtonColor)))),
                        onPressed: () {
                          if(userlogin.read(GetConstant.token)!=null ){
                            if(   userlogin.read(GetConstant.Payment)!=null){
                              if(DateTime.now().isBefore(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").parse(userlogin.read(GetConstant.Payment)))){
                                controller.createAppointement();
                              }else{
                                Get.toNamed(AppRoutes.select_payment);

                              }

                            }else{
                              Get.toNamed(AppRoutes.select_payment);

                            }
                          }else{
                            Get.offAllNamed(AppRoutes.LOGIN);
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppUtils().appBar(
              "Book Appointment",
              "assets/images/cancel.png",
              "assets/images/help.png",
              endIcon,
              leadingIcon,
            )),
        body:  SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          child: Text(
                            "Please Select a date and time onto which you want to book an appointment.",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          )),
                      Container(
                          height: MediaQuery.of(context).size.height * .44,
                          margin:
                              EdgeInsets.only(left: 16, right: 16, bottom: 10),
                          child: SfCalendar(
                            view: CalendarView.month,
                            todayHighlightColor: AppColors.ButtonColor,
selectionDecoration: BoxDecoration(
border: Border.all(color:AppColors.ButtonColor )),
                            onTap: (value) {
                              print("Time" + value.date.toString());
                              controller.changeDate(value.date!);
                              controller.getSlotCallApi();
                            },
                            minDate: DateTime.now(),

                            // by default the month appointment display mode set as Indicator, we can
                            // change the display mode as appointment using the appointment display
                            // mode property
                            monthViewSettings: const MonthViewSettings(
                                appointmentDisplayMode:
                                    MonthAppointmentDisplayMode.appointment),
                          )),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 15,bottom: 10),
                        child: Text(
                          "Time",
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                      controller.slots.length == 0
                          ? Container()
                          : SizedBox(
                              height: 35,
                              child: ListView.builder(
                                  itemCount: controller.slots.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.changeSlot(
                                            index, controller.slots[index]);
                                      },
                                      child: Container(
                                        width: 90,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            color: controller.selectSlot != null
                                                ? controller.selectSlot == index
                                                    ? AppColors.ButtonColor
                                                    : Colors.white
                                                : Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                            child: Text(
                                          DateFormat.jm().format(
                                              DateFormat("hh:mm").parse(
                                                  controller.slots[index])),
                                          textAlign: TextAlign.center,
                                              style: TextStyle(color:  controller.selectSlot != null
                                                  ? controller.selectSlot == index
                                                  ? AppColors.white
                                                  : Colors.black
                                                  : Colors.black,),
                                        )),
                                      ),
                                    );
                                  }),
                            ),

                      /*    Container(
                            margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Payment Method",style: GoogleFonts.montserrat(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),


                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,

                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                fillColor: Colors.green,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    )),
                                contentPadding: EdgeInsets.only(left: 5),
                                errorStyle: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: controller.paymentController.text.isNotEmpty?Text(
                                controller.paymentController.text,
                                style: TextStyle(fontSize: 14),
                              ): Text(
                                'Select',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight:    62,
                              buttonWidth: 40,
                              buttonPadding:
                              const EdgeInsets.only(left: 2, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              items: controller.detailResponse.paymentModes!
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please currency.';
                                }
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.
                                controller.paymentController.text = value.toString();
                              },
                              onSaved: (value) {
                                print(value.toString());
                              },
                            ),
                          ),*/
                      Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Select Your Pet",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 15),
                        width: double.infinity,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            fillColor: Colors.green,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                )),
                            contentPadding: EdgeInsets.only(left: 5),
                            errorStyle: TextStyle(
                                fontSize: 10,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint: controller.paymentController.text.isNotEmpty
                              ? Text(
                                  controller.paymentController.text,
                                  style: TextStyle(fontSize: 14),
                                )
                              : Text(
                                  'Select',
                                  style: TextStyle(fontSize: 14),
                                ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 62,
                          buttonWidth: 40,
                          buttonPadding:
                              const EdgeInsets.only(left: 2, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          items: controller.pets!
                              .map((item) => DropdownMenuItem<Pets>(
                                    value: item,
                                    child: Text(
                                      item.petName.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please currency.';
                            }
                          },
                          onChanged: (value) {
                            //Do something when changing the item if you want.
                            controller.addPet(value as Pets);
                          },
                          onSaved: (value) {
                            print(value.toString());
                          },
                        ),
                      ),


                      Container(

                        margin:
                        EdgeInsets.only(top: 15 ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: AppColors.white,

                        ),
                        child: DropdownButtonFormField2(

                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            fillColor: Colors.green,

                            contentPadding: EdgeInsets.zero,
                            errorStyle: TextStyle(fontSize: 10,fontFamily: "Quicksand",fontWeight: FontWeight.w500,color: AppColors.green),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                )),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                )
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                )

                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,

                          hint: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: const Text(
                              'Select Appointment',
                              style: TextStyle(fontSize: 14),
                            ),
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
                          items: controller.vistSelection
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
                              return 'Please select visit.';
                            }
                          },

                          onChanged: (value) {
                            //Do something when changing the item if you want.
                            controller.vistAppointemnt( value.toString());

                          },
                          onSaved: (value) {
                            print(value.toString());
                          },
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            "Apply Coupon",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.verifyController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  fillColor: AppColors.fillColor,
                                  hintText: '${"Please enter coupon"}',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      )),
                                  border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 50,
                              child: ElevatedButton(
                                  child: Text("Verify".toUpperCase(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14, color: Colors.white)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.ButtonColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side:
                                                  BorderSide(color: AppColors.ButtonColor)))),
                                  onPressed: () {
                                    controller.verifyCall(
                                        controller.verifyController.text);
                                  }),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            "Notes & Request:",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )),
                      Container(
                          height: 160,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: controller.addNotes,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: AppColors.fillColor,
                              hintText: '${"what's going on with your pet"}',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              border: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          )),

                    ],
                  ),
                )),
              ));});

  }
}

endIcon() {
  Get.back();
}

leadingIcon() {
  Get.back();

}
