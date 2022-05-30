import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/onboarding/onboarding.dart';
import 'package:resume_builder/styles/app-themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemes.lightTheme,
      home: OnboardingScreen(),
      enableLog: kDebugMode,
      title: 'Ceevy Builder',
    );
  }
}
