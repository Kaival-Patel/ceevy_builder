import 'package:get/get.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form.dart';
import 'package:resume_builder/modules/create-profile/profile_form_bindings.dart';
import 'package:resume_builder/modules/home/home.dart';
import 'package:resume_builder/modules/init/init.dart';
import 'package:resume_builder/modules/onboarding/onboarding.dart';
import 'package:resume_builder/routes/routes.dart';

class Pages {
  static List<GetPage> routes = [
    GetPage(name: Routes.ONBOARDING, page: () => OnboardingScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.INIT, page: () => InitScreen()),
    GetPage(
        name: Routes.RESUME_PROFILE_FORM,
        page: () => ProfileForm(),
        binding: ProfileFormBindings()),
  ];
}
