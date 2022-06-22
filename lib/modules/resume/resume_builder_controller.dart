import 'package:get/get.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/modules/profile/resume_profile_controller.dart';

class ResumeBuilderController extends GetxController {
  var c = Get.put(ResumeProfilesController());
  Rx<ResumeProfile> selectedProfile = ResumeProfile().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkForCurrentProfile();
  }

  checkForCurrentProfile() async {
    if (c.resumeProfileMap.isNotEmpty) {
      selectedProfile(c.resumeProfileMap.values.first);
    }
  }
}
