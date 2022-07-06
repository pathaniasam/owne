

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ownervet/utils/get_constant.dart';

class AllUsersController extends GetxController{
  late DatabaseReference _userRef;
  late List<DataSnapshot> userDetails;
  late Query query;
  var userlogin=GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _userRef=FirebaseDatabase.instance.ref('allusers').child("SC${userlogin.read(GetConstant.id)}");
    query=     _userRef;
    update();

  }

}