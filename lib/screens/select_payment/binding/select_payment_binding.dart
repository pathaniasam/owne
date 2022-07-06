import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ownervet/screens/select_payment/controller/select_payment_controller.dart';

class SelectPaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SelectPaymentController>(() => SelectPaymentController(),);
  }

}