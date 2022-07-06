import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/booking/controller/booking_controller.dart';
import 'package:ownervet/screens/coummnity/controller/coummnity_controller.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_controller.dart';
import 'package:ownervet/screens/home/controller/home_controller.dart';
import 'package:ownervet/screens/intro/controllers/intro_controllers.dart';

class BookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BookingController>(() => BookingController(),);
  }

}