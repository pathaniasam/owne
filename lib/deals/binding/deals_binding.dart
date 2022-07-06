import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/deals/controller/deals_controller.dart';


class DealsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DealsController>(() => DealsController(),);
  }

}