import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/drawer/controllers/drawer_controllers.dart';
import 'package:ownervet/utils/const_color.dart';


class DrawerMenu extends GetView<DrawersController>
    with WidgetsBindingObserver {
  Size? _size;

  List imagePath = [];

  var userlogin = GetStorage();
  List imageText = [
    "Add Payment",
    "Favorite",
    "Chat",
    "Help",
    "Logout"

  ];
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    print("Countsss" + controller.count.toString());


    return  GetBuilder<DrawersController>(
        init: Get.put<DrawersController>(DrawersController()),
        builder: (controller){
          return Scaffold(
            key: controller.scaffoldkeys,

              body:  Container(
          height: _size!.height,
          child: Column(
          children: [
          Padding(
          padding: const EdgeInsets.only(left: 15, top: 14),
          child: GestureDetector(
          onTap: (){
          Navigator.pop(context);
          },
          child: Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset('assets/svg/close.svg',

          fit: BoxFit.contain),
          ),
          ),
          ),
          SizedBox(
          height: 20,
          ),
          Center(
          child: Image.asset('assets/images/splash.png',
          height: 80,
          width: 80,
          fit: BoxFit.contain)),
          Expanded(
          child: ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemCount: imageText.length,
          itemBuilder: (BuildContext context, int index) {
          return drawerList(
          //imagePath: imagePath.elementAt(index),
          title: imageText.elementAt(index),
          index: index,
          context: context);
          }),
          ),
          ],
          ),
          ));


        });
  }

  Widget drawerList({title, index, context}) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            controller.navigateBoxScreen();
            break;
          case 1:
            controller.navigateFavBoxScreen();
            break;
          case 2:
            controller.navigateBoxChat();
            break;


          case 4:
            showAlertDialog();
            break;

        }
      },
      child: Container(
        // height: _size!.height * 0.09,
        width: _size!.width,
        child: Column(
          children: [
            ListTile(
              dense: true,
            /*  leading: Padding(
                  padding: EdgeInsets.only(left: 23.42),
                  child: Image.asset(
                    imagePath,
                    height: 22.71,
                    width: 25.46,
                    fit: BoxFit.contain,
                  )),*/
              title: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      color: AppColors.text_color,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Quicksand"),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 15.0, right: 17.0),
                child: Divider(
                  color: AppColors.blue,
                  thickness: 1.5,
                )),
          ],
        ),
      ),
    );
  }


    showAlertDialog() {

      // set up the button
      Widget okButton = TextButton(
        child: Text("Yes"),
        onPressed: () {

          controller.logout(onLogoutSuccess: (){

          });
          Navigator.of(controller.scaffoldkeys.currentContext!, rootNavigator: true).pop('dialog');

        },
      );
      Widget noButton = TextButton(
        child: Text("No"),
        onPressed: () {
          Navigator.of(controller.scaffoldkeys.currentContext!, rootNavigator: true).pop('dialog');
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          okButton,
          noButton,
        ],
      );

      // show the dialog
      showDialog(
        context: controller.scaffoldkeys.currentContext!,
        builder: (BuildContext contexts) {
          return alert;
        },
      );

  }



}
