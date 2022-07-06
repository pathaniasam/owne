import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ownervet/screens/select_payment/controller/payment_controller.dart';

class PaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentControllers>(() => PaymentControllers(),);
  }

}