import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder/models/profile/personal_details_model.dart';
import 'package:resume_builder/modules/create-profile/profile_form_controller.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';

class PersonalDetailsForm extends StatefulWidget {
  PersonalDetailsForm({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  var c = Get.find<ProfileFormController>();
  late String pickedPath = c.resume!.pictureAsset;
  TextEditingController nameCTRL = TextEditingController();
  TextEditingController positionCTRL = TextEditingController();
  TextEditingController emailCTRL = TextEditingController();
  TextEditingController contactCTRL = TextEditingController();
  TextEditingController addressCTRL = TextEditingController();

  @override
  void initState() {
    nameCTRL.text = c.resumeProfile.personalDetails.name;
    positionCTRL.text = c.resumeProfile.personalDetails.positionTitle;
    emailCTRL.text = c.resumeProfile.personalDetails.email;
    contactCTRL.text = c.resumeProfile.personalDetails.contact;
    addressCTRL.text = c.resumeProfile.personalDetails.address;
    super.initState();
  }

  bool get isAssetPath => pickedPath.contains('assets/');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipOval(
                    child: Container(
                      height: 90,
                      width: 90,
                      child: Stack(
                        children: [
                          Center(
                            child: ClipOval(
                              child: Container(
                                height: 70,
                                width: 70,
                                color: context.theme.cardColor,
                                child: ClipOval(
                                  child: isAssetPath
                                      ? Image.asset(
                                          pickedPath,
                                          height: 45,
                                          width: 45,
                                        )
                                      : Image.file(
                                          File(pickedPath),
                                          height: 45,
                                          width: 45,
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, bottom: 10),
                              child: ClipOval(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  color: context.theme.primaryColor,
                                  child: IconButton(
                                    splashRadius: 20,
                                    icon: SvgPicture.asset(
                                      AppAssets.editIcon,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      var result = await ImagePicker.platform
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (result != null) {
                                        pickedPath = result.path;
                                        c.resume!.pictureAsset = pickedPath;
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Display Picture',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Full Name',
                  filled: true,
                  controller: nameCTRL,
                  keyBoardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Full name cannot be empty';
                    }
                  },
                  onChanged: (v) {},
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hint: 'Position Title (Lead Designer)',
                  filled: true,
                  controller: positionCTRL,
                  keyBoardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Position Title cannot be empty';
                    }
                  },
                  onChanged: (v) {},
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: emailCTRL,
                  hint: 'Email (abc@gmail.com)',
                  filled: true,
                  keyBoardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Email address cannot be empty';
                    }
                  },
                  onChanged: (v) {},
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: contactCTRL,
                  hint: 'Contact (+1 125 632 1455)',
                  filled: true,
                  keyBoardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Contact cannot be empty';
                    }
                  },
                  onChanged: (v) {},
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: addressCTRL,
                  hint: 'Address (23, Sky Avenue)',
                  filled: true,
                  keyBoardType: TextInputType.streetAddress,
                  maxLine: 2,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Address cannot be empty';
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
                c.resumeProfile.pictureAsset = pickedPath;
                c.resumeProfile.personalDetails = PersonalDetails(
                    address: addressCTRL.text.trim(),
                    contact: contactCTRL.text.trim(),
                    email: emailCTRL.text.trim(),
                    name: nameCTRL.text.trim(),
                    positionTitle: positionCTRL.text.trim());
                c.saveResume(c.resumeProfile);
                c.currentProfileStep(c.currentProfileStep() + 1);
              },
              child: Text('Save and Next')),
        )
      ],
    );
  }
}
