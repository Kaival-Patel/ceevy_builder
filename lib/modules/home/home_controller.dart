import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/browse/browse.dart';
import 'package:resume_builder/modules/profile/resume_profiles.dart';
import 'package:resume_builder/modules/settings/settings.dart';

class HomeController extends GetxController {
  List<Widget> bottomTabs = [
    Browse(),
    ResumeProfiles(),
    Settings(),
  ];
  RxInt selectedTab = 0.obs;
}
