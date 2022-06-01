import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resume_builder/routes/routes.dart';
import 'package:resume_builder/utils/constants/strings.dart';
import 'package:resume_builder/utils/widgets/loader.dart';

class InitScreen extends StatefulWidget {
  InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> with WidgetsBindingObserver {
  var storage = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decideNavigation();
  }

  decideNavigation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var isOnboardingCompleted =
          storage.read(StorageKeys.ONBOARDING_COMPLETE) ?? false;
      if (isOnboardingCompleted) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.toNamed(Routes.ONBOARDING);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Loader(
        size: 30,
      )),
    );
  }
}
