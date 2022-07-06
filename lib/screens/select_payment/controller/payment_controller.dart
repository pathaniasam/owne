

import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/request/take_subscription_request.dart';
import 'package:ownervet/model/response/login_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class PaymentControllers extends GetxController{
  CardFieldInputDetails? card;
  TokenData? tokenData;
  var userlogin=GetStorage();
  String? id;
  var isLogin=false;


  @override
  void onInit() {

    print("ids"+id.toString());
  }

  updateCard(CardFieldInputDetails? cardDetail) {
    card = cardDetail;
    update();
  }

  callPayemnt(){
    AppUtils().checkInternet().then((value) async{
      if(value){
        tokenData = await Stripe.instance.createToken(
          CreateTokenParams(
            type: TokenType.Card,
          ),
        );
        if(tokenData==null){
          AppUtils.Snackbar("Token", "Please add card");
          return;
        }
        isLogin=true;
        update();
        print("Payment Token"+tokenData!.id.toString() );
        TakeSubscriptionRequest request=TakeSubscriptionRequest(token: tokenData!.id.toString()  ,planId: id);
        ApiHelper.post(NetworkUtils.subscription,body:request.toJson(),authtoken: userlogin.read(GetConstant.token)).then((values) {
if(values!.statusCode==201){
  LoginResponse response=LoginResponse.fromJson(jsonDecode(values.data));
  AppUtils.Snackbar("Success", response.message);

  userlogin.write(GetConstant.isPayment, true);
  Get.offAllNamed(AppRoutes.HOME);
  isLogin=false;

  update();


}else{
  isLogin=false;
  update();
}
        });
      }else{

      }
    });
  }

}