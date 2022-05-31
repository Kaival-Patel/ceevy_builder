import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/onboarding_model.dart';
import 'package:resume_builder/styles/app-colors.dart';

class OnboardingController extends GetxController {
  PageController smController = PageController();
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
          assetPath: 'assets/images/onboarding_1.png',
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
          assetPath: 'assets/images/onboarding_2.png',
          height: Get.height * 0.45,
          width: Get.width,
          alignment: Alignment.topCenter,
          radius: BorderRadius.only(
            bottomRight: Radius.circular(Get.height * 0.25),
            bottomLeft: Radius.circular(Get.height * 0.25),
          ),
          bgCurveColor: AppColors.lightYellow,
          title: 'Create your resume',
          description:
              'Create your resume in a few clicks. You can add your personal details, work experience, education, skills, projects, awards, and more.'),
      OnboardingModel(
          assetPath: 'assets/images/onboarding_3.png',
          bgCurveColor: AppColors.lightBlueAccent,
          alignment: Alignment.topRight,
          height: Get.height * 0.45,
          width: Get.width * 0.8,
          radius: BorderRadius.only(
            bottomLeft: Radius.circular(Get.height * 0.45),
          ),
          title: 'Share your resume',
          description:
              'Share your resume with your friends and colleagues. You can also share your resume with your employer.'),
    ];
  }
}
