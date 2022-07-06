import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/chat/controllers/all_users_controller.dart';




class AllUsersBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AllUsersController>(() => AllUsersController(),);
  }

}