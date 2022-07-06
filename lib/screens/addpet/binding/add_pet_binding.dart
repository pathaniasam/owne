import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/addpet/controller/add_pet_controlller.dart';
import 'package:ownervet/screens/splash/controller/splash_controller.dart';

class AddPetBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddPetController>(() => AddPetController(),);
  }

}