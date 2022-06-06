import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/browse/browse.dart';
import 'package:resume_builder/modules/profile/resume_profiles.dart';

class HomeController extends GetxController {
  List<Widget> bottomTabs = [
    Browse(),
    ResumeProfiles(),
    Container(),
  ];
  RxInt selectedTab = 0.obs;
}
