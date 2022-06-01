import 'package:get/get.dart';
import 'package:resume_builder/modules/home/home.dart';
import 'package:resume_builder/modules/init/init.dart';
import 'package:resume_builder/modules/onboarding/onboarding.dart';
import 'package:resume_builder/routes/routes.dart';

class Pages {
  static List<GetPage> routes = [
    GetPage(name: Routes.ONBOARDING, page: () => OnboardingScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.INIT, page: () => InitScreen()),
  ];
}
