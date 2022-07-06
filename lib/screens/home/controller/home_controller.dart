import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/booking/view/booking_view.dart';
import 'package:ownervet/deals/view/deals_view.dart';
import 'package:ownervet/screens/coummnity/view/coummnity_view.dart';
import 'package:ownervet/screens/dashboard/view/dashboard_view.dart';
import 'package:ownervet/screens/search/view/search_view.dart';
import 'package:ownervet/src/managers/push_notifications_manager.dart';
import 'package:ownervet/utils/const_color.dart';
import 'package:ownervet/utils/get_constant.dart';
import 'package:ownervet/utils/pref_util.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeController extends GetxController {
  PersistentTabController tabcontroller =
      PersistentTabController(initialIndex: 0);
  var userlogin = GetStorage();

  List<Widget> buildScreens = <Widget>[
    DashboardView(),
    CoummnityView(),
    SearchView(),
    DealsView(),
    BookingView()
  ];

  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    // loginConnection();
  }

  loginConnection() {
    if (userlogin.read(GetConstant.id) != null) {
      getUserByLogin("own" + userlogin.read(GetConstant.id).toString())
          .then((cubeUser) {
        CubeUser users = CubeUser(
          id: cubeUser!.id!,
          login: "own" + userlogin.read(GetConstant.id).toString(),
          fullName: userlogin.read(GetConstant.name),
          password: "supersecurepwd",
        );
        CubeChatConnection.instance.login(users).then((cubeUser) {
          //Get.offAllNamed(AppRoutes.HOME);
          SharedPrefs.saveNewUser(users);

          PushNotificationsManager.instance.init();
        }).catchError((exception) {
          print(exception);
          //   _processLoginError(exception);
        });
      });
    }
  }
/*  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),

        activeColorPrimary: AppColors.ButtonColor,

        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person_3_fill),
        title: ("Community"),
        activeColorPrimary: AppColors.ButtonColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.location),
        title: ("Search"),
        activeColorPrimary: AppColors.ButtonColor,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.folder),
        title: ("Deals"),
        activeColorPrimary: AppColors.ButtonColor,
        inactiveColorPrimary: Colors.black,
      ),  PersistentBottomNavBarItem(
        icon: Image.asset("assets/images/calendars.png",height: 30,width: 30xs,),
        title: ("Bookings"),
        activeColorPrimary: AppColors.ButtonColor,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }*/

  List<BottomNavigationBarItem> navBarsItems() {
    return [
      BottomNavigationBarItem(
        label: ("Home"),
        activeIcon: Image.asset(
          "assets/images/hom.png",
          height: 35,
          width: 35,
          fit: BoxFit.contain,
          color: AppColors.ButtonColor,
        ),
        icon: Image.asset(
          "assets/images/hom.png",
          height: 30,
          width: 30,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
      ),
      BottomNavigationBarItem(
        label: ("Community"),
        activeIcon: Image.asset(
          "assets/images/com.png",
          height: 40,
          width: 40,
          fit: BoxFit.contain,
          color: AppColors.ButtonColor,
        ),
        icon: Image.asset(
          "assets/images/com.png",
          height: 40,
          width: 40,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
      ),
      BottomNavigationBarItem(
        label: ("Search"),
        activeIcon: Image.asset(
          "assets/images/loc.png",
          height: 35,
          width: 35,
          fit: BoxFit.contain,
          color: AppColors.ButtonColor,
        ),
        icon: Image.asset(
          "assets/images/loc.png",
          height: 30,
          width: 30,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/deal.png",
          height: 30,
          width: 30,
          fit: BoxFit.contain,
        ),
        label: ("Service"),
        backgroundColor: Colors.black,
        activeIcon: Image.asset(
          "assets/images/deal.png",
          height: 35,
          width: 35,
          fit: BoxFit.contain,
          color: AppColors.ButtonColor,
        ),
      ),
      BottomNavigationBarItem(
        label: ("Appointments"),
        activeIcon: Image.asset(
          "assets/images/cal.png",
          height: 35,
          width: 35,
          fit: BoxFit.contain,
          color: AppColors.ButtonColor,
        ),
        icon: Image.asset(
          "assets/images/cal.png",
          height: 30,
          width: 30,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.black,
      ),
    ];
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
