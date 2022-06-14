import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/utils/constants/constants.dart';

class ProfileFormBindings extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    if (args is ResumeProfile) {
      Get.put(ProfileFormController(resume: args));
    } else {
      Get.put(ProfileFormController());
    }
  }
}
