
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ownervet/utils/const_color.dart';

class AppUtils{
  static final AppUtils _singleton = AppUtils._internal();

  factory AppUtils() {
    return _singleton;
  }

  AppUtils._internal();
  DateFormat profileDateformat = DateFormat('yyyy-MM-dd');

  Widget appBar(String title,String leadingIcons,String endIcon,Function endingIcon,Function leadingIcon,){
    return SafeArea(
      child: Container(

        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
            leadingIcon();
            }, icon: Image.asset(leadingIcons)),
            Text(title,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w600,color:AppColors.titleColor),),
            Image.asset(endIcon),

          ],
        ),
      ),
    );
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static void Snackbar(title, message) {
    Get.snackbar(title, message,
        colorText: Colors.white, backgroundColor: AppColors.blue);
  }

  selectDate(
      {required BuildContext context,
        DateTime? initialDate,
        required DateTime firstDate,
        DateTime? lastDate,
        required Function(DateTime) onDateSelected}) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate ?? DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.green,
              onPrimary: Colors.white,
              onSurface: AppColors.text_color,
              surface: AppColors.green,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.green, // button text color
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (pickedDate != null) {
      // controller.tecOrderDate.text = dateFormat.format(pickedDate);
      // controller.orderDate = controller.tecOrderDate.text;
      onDateSelected(pickedDate);
    } else {
      return;
    }
  }

  String getDateComplete(String? date) {
    // DateTime tempDate = new DateFormat("yyyy-MMM-ddTHH:mm:ss").parse(date);
    if (date == null) {
      return "";
    }
    var outputDate = "";
    try {
      DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd.MM.yyyy');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {}
    return outputDate;
  }

  String getDateCompletes(String? date) {
    // DateTime tempDate = new DateFormat("yyyy-MMM-ddTHH:mm:ss").parse(date);
    if (date == null) {
      return "";
    }
    var outputDate = "";
    try {
      DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {}
    return outputDate;
  }

  String getDateCompletesBooking(String? date) {
    // DateTime tempDate = new DateFormat("yyyy-MMM-ddTHH:mm:ss").parse(date);
    if (date == null) {
      return "";
    }
    var outputDate = "";
    try {
      DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {}
    return outputDate;
  }
  String getDateSlot(String? date) {
    // DateTime tempDate = new DateFormat("yyyy-MMM-ddTHH:mm:ss").parse(date);
    if (date == null) {
      return "";
    }
    var outputDate = "";
    try {
      DateTime parseDate =
      new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {}
    return outputDate;
  }
}