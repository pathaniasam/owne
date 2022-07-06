

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/home/controller/home_controller.dart';
import 'package:ownervet/src/managers/call_manager.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeView extends GetView<HomeController>{
  @override
  Widget build(BuildContext context) {
    CallManager.instance.init(context);

    return GetBuilder<HomeController>(
        init: Get.put<HomeController>(
        HomeController()),
    builder: (controller) {
    print("TabController"+controller.selectedIndex.toString());
    return  Scaffold(
    body:  Center(
      child: controller.buildScreens.elementAt(controller.selectedIndex),
    ),
      bottomNavigationBar:  BottomNavigationBar(
          items: controller.navBarsItems(),
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex,
          selectedItemColor: AppColors.ButtonColor,
          selectedFontSize:12,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle:TextStyle(fontSize: 10) ,
          onTap:(indx){
            controller.onItemTapped(indx);
          },
          elevation: 5
      ),

  );
  }

    );}
}