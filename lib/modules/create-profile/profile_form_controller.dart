import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/base_resume_class.dart';
import 'package:resume_builder/modules/create-profile/education_details_form.dart';
import 'package:resume_builder/modules/create-profile/personal_details_form.dart';
import 'package:resume_builder/modules/create-profile/skill_details_form.dart';
import 'package:resume_builder/modules/create-profile/summary_details_form.dart';
import 'package:resume_builder/modules/create-profile/work_history_form.dart';

class ProfileFormController extends GetxController {
  ResumeProfile? resume;
  ProfileFormController({this.resume}) {
    if (this.resume == null) {
      this.resume = ResumeProfile();
    }
  }

  late ResumeProfile resumeProfile = resume ?? ResumeProfile();
  RxInt currentProfileStep = 0.obs;

  RxList<String> formStepsName = <String>[
    'Personal\nDetails',
    'Summary\nDetails',
    'Education\nDetails',
    'Skills\nDetails',
    'Work\nHistory'
  ].obs;

  Color currentFormColor(BuildContext context, int index) =>
      currentProfileStep.value == index
          ? context.theme.primaryColor
          : context.theme.disabledColor;
  Color currentDotColor(BuildContext context) => context.theme.accentColor;
  Color prevDotColor(BuildContext context) => context.theme.primaryColor;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void saveResume(ResumeProfile profile) async {
    var storage = GetStorage();
    storage.write(profile.id, resumeProfileToJson(profile));
  }
}
