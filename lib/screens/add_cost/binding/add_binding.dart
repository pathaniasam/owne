
import 'package:get/get.dart';
import 'package:ownervet/screens/add_cost/controller/add_cost_controller.dart';

class AddCostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddCostController>(() => AddCostController(),);
  }

}