
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/auth/controller/google_controller.dart';
import 'package:ownervet/screens/auth/controller/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(),);
  }

}