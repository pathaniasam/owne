

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/model/response/favorites_response.dart';
import 'package:ownervet/repository/dio_services.dart';
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/utils/app_utils.dart';
import 'package:ownervet/utils/get_constant.dart';

class FavouriteController extends GetxController{
  var userlogin=GetStorage();
  List<ProfessionalsFav> professionals=[];

  @override
  void onInit() {
    super.onInit();
    
    getFavoritesCall();
  }

  void getFavoritesCall() {
    AppUtils().checkInternet().then((value) {
      if(value){
        ApiHelper.get(NetworkUtils.favourites,authtoken: userlogin.read(GetConstant.token)).then((values) {
          FavouriteResponse response=FavouriteResponse.fromJson(jsonDecode(values.data));
          professionals.addAll(response.professionals!);
          update();

        });
      }else{
        
      }
    });
  }

  callFavouriteApi(int? id){
    AppUtils().checkInternet().then((value) {
      if(value){
        ApiHelper.put(NetworkUtils.professional+id.toString()+"/"+"favourite",authtoken: userlogin.read(GetConstant.token)).then((values) {

        });
      }else{

      }
    });
  }

  updateFavourite(int index){
    professionals.removeAt(index);
    update();

  }

}