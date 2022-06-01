import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/config/init_config.dart';
import 'package:resume_builder/modules/onboarding/onboarding.dart';
import 'package:resume_builder/routes/pages.dart';
import 'package:resume_builder/routes/routes.dart';
import 'package:resume_builder/styles/app-themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitConfig.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemes.lightTheme,
      enableLog: kDebugMode,
      getPages: Pages.routes,
      initialRoute: Routes.INIT,
      title: 'Ceevy Builder',
    );
  }
}
