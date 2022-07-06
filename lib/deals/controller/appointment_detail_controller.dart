import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:ownervet/model/request/all_users.dart';
import 'package:ownervet/model/request/cancelled_appoitment.dart';
import 'package:ownervet/model/response/all_appointment_detail_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';


class AppointmentDetailController extends GetxController{
  var userlogin=GetStorage();
  AllAppointemntDetailData? data;
  List<DServices> services=[];
  List<AllUsers> users=[];
  FirebaseFirestore storage=FirebaseFirestore.instance;
  int? id;
  var items;
  bool isLoading=true;
  bool isAccept=false;
  bool isCancel=false;
  bool isLoadings=false;
  @override
  void onInit() {
    super.onInit();

    getAllApointement();

  }
  void getAllApointement() {
    AppUtils().checkInternet().then((value) {
      if(value){
        isLoading=true;
        update();
        ApiHelper.get(NetworkUtils.createAppointment+"/"+id.toString(),authtoken: userlogin.read(GetConstant.token)).then((values){
          if(values!.statusCode==200){
           data=AllAppointemntDetailData.fromJson(jsonDecode(values.data));
           // data=response.data;
            services.addAll(data!.services!);
            items = services
                .map((animal) => MultiSelectItem<DServices>(animal, animal.name!))
                .toList();
            isLoading=false;

            update();
          }else{

          }
        });
      }else{

      }
    });
  }

/*  void updates(String status){
    AppUtils().checkInternet().then((value) {
      if(value){
        UpdateAppointment request;
        if(status=="Cancelled"){
          isCancel=true;
          request=UpdateAppointment(status:status ,reason: "qw");
        }else{
          isAccept=true;
          request=UpdateAppointment(status:status ,);

        }
        update();


        ApiHelper.put(NetworkUtils.appointments+"/"+id.toString(),authtoken: userlogin.read(GetConstant.token),body: request.toJson()).then((values) {
          if(values!.statusCode==200){
          LoginResponse request=LoginResponse.fromJson(jsonDecode(values.data));
          AppUtils.Snackbar("Success", request.message);
          if(status=="Cancelled"){
            isCancel=false;
          }else{

            isAccept=false;

          }
          getAllApointement();
          //Get.offAndToNamed(AppRoutes.HOME);
          update();

          }else{
            LoginResponse request=LoginResponse.fromJson(values.data);
            AppUtils.Snackbar("Error", request.message);

            if(status=="Cancelled"){
              isCancel=false;
            }else{
              isAccept=false;
            }
            update();

          }
        });
      }else{

      }
    });
  }*/


  void cancelledAppointment(String ids) {
    AppUtils().checkInternet().then((value) {
      if(value){
        isLoadings=true;
        update();
        CancelledAppointmentRequest request=CancelledAppointmentRequest(reason:"No need",status: "Cancelled");
        ApiHelper.put(NetworkUtils.createAppointment+"/"+ids.toString(),authtoken: userlogin.read(GetConstant.token,),body: request
        .toJson()).then((values){
          if(values!.statusCode==200){
         AppUtils.Snackbar("Success", "Appointment status has been cancelled successfully");
            isLoadings=false;

            update();
          }else{

          }
        });
      }else{

      }
    });
  }

}