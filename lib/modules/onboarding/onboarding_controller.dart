import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/onboarding/onboarding_model.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/styles/app-colors.dart';

class OnboardingController extends GetxController {
  List<OnboardingModel> models = [];
  RxInt page = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeModel();
  }

  int get index => page();

  initializeModel() {
    models = [
      OnboardingModel(
          assetPath: AppAssets.onboarding1,
          bgCurveColor: AppColors.lightBlue,
          height: Get.height * 0.45,
          width: Get.width * 0.8,
          alignment: Alignment.topLeft,
          radius: BorderRadius.only(
            bottomRight: Radius.circular(Get.height * 0.45),
          ),
          title: 'Welcome to Ceevy Builder',
          description:
              'Ceevy Builder is a tool to help you build your resume in a few clicks.'),
      OnboardingModel(
          assetPath: AppAssets.onboarding2,
          height: Get.height * 0.45,
          width: Get.width,
          alignment: Alignment.topCenter,
          radius: BorderRadius.only(
            bottomRight: Radius.circular(Get.height * 0.25),
            bottomLeft: Radius.circular(Get.height * 0.25),
          ),
          bgCurveColor: AppColors.lightYellow,
          title: 'Download your resume',
          description:
              'Create your resume in a few clicks. You can add your personal details, work experience, education, skills, projects, awards, and more.'),
      OnboardingModel(
          assetPath: AppAssets.onboarding3,
          bgCurveColor: AppColors.lightBlueAccent,
          alignment: Alignment.topRight,
          height: Get.height * 0.45,
          width: Get.width * 0.8,
          radius: BorderRadius.only(
            bottomLeft: Radius.circular(Get.height * 0.45),
          ),
          title: 'Enhance your resume',
          description:
              'Edit your resume and share it with your friends and colleagues'),
    ];
  }
}
