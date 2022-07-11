import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/models/profile/summary_details_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';

class SummaryDetailsForm extends StatelessWidget {
  SummaryDetailsForm({Key? key}) : super(key: key);
  var c = Get.find<ProfileFormController>();
  TextEditingController summaryCTRL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    summaryCTRL.text = c.resumeProfile.sumamryDetails.introduction;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint:
                      'Introducton or short summary about you (will reflect on top part of resume)',
                  filled: true,
                  maxLine: 5,
                  controller: summaryCTRL,
                  keyBoardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Summary cannot be empty';
                    }
                  },
                  onChanged: (v) {},
                ),
              ],
            ),
          )),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                c.resumeProfile.sumamryDetails = SummaryDetails(
                  introduction: summaryCTRL.text,
                );
                c.saveResume(c.resumeProfile);
                c.currentProfileStep(c.currentProfileStep() + 1);
              },
              child: Text('Save and Next')),
        )
      ],
    );
  }
}
