


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/screens/myprofile/controller/my_profile_controller.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/const_color.dart';

class MyProfileView extends GetView<MyProfileController>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.offNamed(AppRoutes.HOME);
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton: Container(
          width: double.infinity,
          margin: EdgeInsets.all(15),

          child: FloatingActionButton.extended(
            onPressed: (){
              Get.toNamed(AppRoutes.AddPet);
            },
            backgroundColor: AppColors.text_color,


            label: Text('Add Pet'),
          ),
        ),

          appBar: PreferredSize(preferredSize: Size.fromHeight(80),
              child: AppUtils().appBar("My Profile", "assets/images/cancel.png","assets/images/help.png", endIcon, leadingIcon, )),

      body: SafeArea(
          child:  GetBuilder<MyProfileController>(
            init: Get.put<MyProfileController>(MyProfileController()),
      builder: (controller) {
      //  controller.onInit();
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 25,right: 20,),
              child: Row(
                children: [
                  Image.asset("assets/images/person.png"),
                  SizedBox(width: 8,),
                  Text("My Details:",style:GoogleFonts.montserrat(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)
                ],
              ),
            ),

            SizedBox(height: 15,),
        controller.myRresponses==null?Container():    Container(
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    controller.myRresponses!.profileImage == null
                        ?
                    Image.asset(
                      "assets/images/my_profile.png", height: 60, width: 60,)
                        : Container(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CachedNetworkImage(
                          imageUrl: controller.myRresponses!.profileImage!,
                          progressIndicatorBuilder: (context, url,
                              downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),),
                    SizedBox(width: 8,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(controller.myRresponses!.name!, style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                      Text(controller.myRresponses!.email!,style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black)),
                      controller.myRresponses!.mobile == null ? Container() : Text(
                          controller.myRresponses!.mobile!,style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black))
                    ],))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 15),
              child: Row(
                children: [
                  Image.asset("assets/images/dog_profile.png"),
                  SizedBox(width: 8,),
                  Text("My Pets:",style:GoogleFonts.montserrat(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),)
                ],
              ),
            ),

            controller.pets.length==0?Container():        Expanded(
              child: ListView.builder(
                itemCount: controller.pets.length,
                  itemBuilder:(context,index){
                  return   Container(
                    margin: EdgeInsets.only(top: 10,left: 15,right: 15),

                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(2),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              controller.pets[index].image==null?          Image.asset(
                                "assets/images/my_profile.png", height: 60, width: 60,)
                                  : Container(
                                height: 60,
                                width: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImage(
                                    imageUrl:controller.pets[index].image!,
                                    progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),),
                              SizedBox(width: 8,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.pets[index].petName!, style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                                 SizedBox(height: 2,),
                                  Text(controller.pets[index].species!,style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black)),
                                  SizedBox(height: 2,),

                                  Text(controller.pets[index].breed!,style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black)),
                                  SizedBox(height: 2,),

                                  Text(AppUtils().getDateComplete(controller.pets[index].dob!),style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black)),
                                  SizedBox(height: 2,),

                                  Text(controller.pets[index].gender!,style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black)),
                                  SizedBox(height: 2,),

                                  Text(controller.pets[index].weight.toString()!,style:GoogleFonts.montserrat(fontSize: 16,color: Colors.black)),
                                ],))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

              }),
            )
          ],
        );

      })),
      ),
    );
  }


  leadingIcon() {
  Get.offNamed(AppRoutes.HOME);
  }
  endIcon() {

  }
}