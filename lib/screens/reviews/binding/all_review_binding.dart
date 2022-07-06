import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/reviews/controllers/all_review_controller.dart';


class AllReviewsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AllReviewController>(() => AllReviewController(),);
  }

}