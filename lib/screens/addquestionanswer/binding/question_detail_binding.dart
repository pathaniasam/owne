import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/addquestionanswer/controller/add_question_controller.dart';
import 'package:ownervet/screens/addquestionanswer/controller/question_detail_controller.dart';

class QuestionDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddQuestionDetailController>(() => AddQuestionDetailController(),);
  }

}