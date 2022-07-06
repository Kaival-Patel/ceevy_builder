import 'package:get/get.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/modules/profile/resume_profile_controller.dart';
import 'package:resume_builder/modules/resume/create_profile_suggestion_dialog.dart';

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
    if (c.resumeProfileMap.values.isNotEmpty) {
      selectedProfile(c.resumeProfileMap.values.first);
    } else {
      await 0.5.delay();
      await Get.bottomSheet(CreateProfileSuggestion(), isScrollControlled: true);
      c.fetchProfiles();
    }
  }
}
