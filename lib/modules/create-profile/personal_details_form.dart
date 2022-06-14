import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';

class PersonalDetailsForm extends StatelessWidget {
  PersonalDetailsForm({Key? key}) : super(key: key);
  var c = Get.find<ProfileFormController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("PERSONAL DETAILS FORM"),
    );
  }
}
