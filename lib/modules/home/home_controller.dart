import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/browse/browse.dart';

class HomeController extends GetxController {
  List<Widget> bottomTabs = [
    Browse(),
    Container(),
    Container(),
  ];
  RxInt selectedTab = 0.obs;
}
