import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/auth/controller/claim_controller.dart';



class ClaimBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ClaimControllerController>(() => ClaimControllerController(),);
  }

}