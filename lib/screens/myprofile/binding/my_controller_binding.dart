import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/home/controller/home_controller.dart';
import 'package:ownervet/screens/intro/controllers/intro_controllers.dart';
import 'package:ownervet/screens/myprofile/controller/my_profile_controller.dart';

class MyProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() => MyProfileController(),);
  }

}