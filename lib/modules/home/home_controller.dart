import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Widget> bottomTabs = [
    Container(),
    Container(),
    Container(),
  ];
  RxInt selectedTab = 0.obs;
}
