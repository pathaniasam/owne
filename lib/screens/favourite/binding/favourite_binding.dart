import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/favourite/controller/favourite_controller.dart';

class FavouriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FavouriteController>(() => FavouriteController(),);
  }

}