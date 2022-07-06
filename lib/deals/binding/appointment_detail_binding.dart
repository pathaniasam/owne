import 'package:get/get.dart';
import 'package:ownervet/deals/controller/appointment_detail_controller.dart';

class AppointmentDetailBinidng extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AppointmentDetailController>(() => AppointmentDetailController(),);
  }

}