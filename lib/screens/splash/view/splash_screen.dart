
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/screens/splash/controller/splash_controller.dart';
import 'package:ownervet/utils/const_color.dart';

class SplashScren extends GetView<SplashController>{
  @override
  Widget build(BuildContext context) {
    bool value = controller.isStopTimer.value;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.12,),
            Image.asset(
              'assets/images/splash_logo.png',),
            Text("FAREVET",style: TextStyle(fontSize: 26,fontFamily: "SF",fontWeight: FontWeight.w400,color:AppColors.text_color)),
            Text("Find low Cost Vet Care \n & Pet Services",textAlign:TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: "SF",fontWeight: FontWeight.w400,color:AppColors.text_color)),
          ],
        ),
      ),
    );
  }

}