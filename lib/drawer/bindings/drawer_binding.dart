import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/drawer/controllers/drawer_controllers.dart';

class DrawerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DrawersController>(() => DrawersController(),);
  }

}