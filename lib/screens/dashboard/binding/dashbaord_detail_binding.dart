import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_controller.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';

class DashBoardDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashBoardDetailController>(() => DashBoardDetailController(),);
  }

}