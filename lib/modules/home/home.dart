import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/home/home_controller.dart';
import 'package:resume_builder/styles/app-assets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var c = Get.put(HomeController());
  double iconSize = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Browse',
              icon: SvgPicture.asset(
                AppAssets.home,
                height: iconSize,
                width: iconSize,
              ),
              activeIcon: SvgPicture.asset(
                AppAssets.homeFilled,
                height: iconSize,
                color: context.theme.primaryColor,
                width: iconSize,
              ),
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: SvgPicture.asset(
                AppAssets.user,
                height: iconSize,
                width: iconSize,
              ),
              activeIcon: SvgPicture.asset(
                AppAssets.userFilled,
                height: iconSize,
                width: iconSize,
                color: context.theme.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.settings,
                height: iconSize,
                width: iconSize,
                color: context.theme.primaryColor,
              ),
              label: 'Settings',
              activeIcon: SvgPicture.asset(
                AppAssets.settingsFilled,
                height: iconSize,
                width: iconSize,
                color: context.theme.primaryColor,
              ),
            ),
          ],
          selectedLabelStyle:
              TextStyle(color: context.theme.primaryColor, fontSize: 12),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: (v) {
            c.selectedTab(v);
          },
          currentIndex: c.selectedTab(),
        ),
      ),
      body: Obx(() => c.bottomTabs[c.selectedTab()]),
    );
  }
}
