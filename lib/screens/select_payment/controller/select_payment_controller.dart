import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/response/all_plans.dart';
import 'package:ownervet/model/response/my_subscription.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class SelectPaymentController extends GetxController {
  var userlogin = GetStorage();
  PlansResponse? response;
  var isLoading = false;
  MySubscription? subscription;
  @override
  void onInit() {
    super.onInit();
    callPaymentApi();
    getMySubscription();
  }

  void getMySubscription() {
    AppUtils().checkInternet().then((value) {
      if(value){

        ApiHelper.get(NetworkUtils.subscription,authtoken: userlogin.read(GetConstant.token),).then((values) {
          if(values.statusCode==200){
             subscription=MySubscription.fromJson(jsonDecode(values.data));
            userlogin.write(GetConstant.Payment,subscription!.subscription!.validityEndOn);

          }else{
            subscription=null;
          }
          update();
        });
      }else{

      }
    });
  }

  void callPaymentApi() {
    AppUtils().checkInternet().then((value) {
      if (value) {
        isLoading = true;
        update();
        ApiHelper.get(NetworkUtils.getAllPlans,
                authtoken: userlogin.read(GetConstant.token))
            .then((values) {
          if (values.statusCode == 200) {
            response = PlansResponse.fromJson(jsonDecode(values.data));
            isLoading = false;
            ;
            update();
          } else {
            isLoading = false;
            ;
            update();
          }
        });
      } else {}
    });
  }
}
