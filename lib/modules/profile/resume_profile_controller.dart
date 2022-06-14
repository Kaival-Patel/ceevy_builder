import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/constants/strings.dart';

class ResumeProfilesController extends GetxController {
  GetStorage storage = GetStorage();
  RxMap<String, ResumeProfile> resumeProfileMap = <String, ResumeProfile>{}.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfiles();
  }

  fetchProfiles() async {
    var keys = storage.getKeys();
    keys = keys.toList();
    for (int i = 0; i < keys.length; i++) {
      if (keys[i] != StorageKeys.ONBOARDING_COMPLETE) {
        var key = keys[i];
        logger.d(key);
        var profile = storage.read(key);
        logger.d(profile.runtimeType);
        resumeProfileMap[key] = resumeProfileFromJson(profile);
      }
    }
  }
}
