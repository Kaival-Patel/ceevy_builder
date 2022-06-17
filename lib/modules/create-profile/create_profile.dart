import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/routes/routes.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/utils/constants/constants.dart';
import 'package:resume_builder/utils/widgets/snackbar.dart';
import 'package:resume_builder/utils/widgets/textfield.dart';
import 'package:uuid/uuid.dart';

class CreateProfile extends StatelessWidget {
  CreateProfile({Key? key}) : super(key: key);
  List<String> avatars = [
    AppAssets.profile_1,
    AppAssets.profile_2,
    AppAssets.profile_3,
    AppAssets.profile_4,
    AppAssets.profile_5,
    AppAssets.profile_6,
  ];
  late RxString selectedAvatar = avatars.first.obs;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.theme.scaffoldBackgroundColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: 45, height: 4, color: context.theme.hoverColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Create Profile',
                  style: context.textTheme.headline6,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              Container(
                width: context.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Profile Avatar',
                        style: TextStyle(
                          color: context.theme.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Obx(
                            () => GestureDetector(
                              onTap: () {
                                selectedAvatar(avatars[index]);
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color:
                                            selectedAvatar() == avatars[index]
                                                ? context.theme.primaryColor
                                                : context.theme.disabledColor,
                                        width:
                                            selectedAvatar() == avatars[index]
                                                ? 1
                                                : 0.2)),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          selectedAvatar() == avatars[index]
                                              ? const EdgeInsets.all(3.0)
                                              : EdgeInsets.zero,
                                      child: ClipOval(
                                          child: Image.asset(
                                        avatars[index],
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.cover,
                                      )),
                                    ),
                                    Obx(() {
                                      return Visibility(
                                        visible:
                                            selectedAvatar() == avatars[index],
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ClipOval(
                                              child: Container(
                                            height: 18,
                                            width: 18,
                                            color: context.theme.accentColor,
                                            child: Center(
                                                child: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 12,
                                            )),
                                          )),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          itemCount: avatars.length,
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: context.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Name',
                        style: TextStyle(
                          color: context.theme.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Form(
                        key: formKey,
                        child: CustomTextField(
                          hint: 'Eg : Lakhan\'s Profile',
                          filled: true,
                          controller: controller,
                          validator: (v) {
                            if (v!.trim().isEmpty) {
                              return 'Profile name cannot be empty';
                            }
                          },
                          onChanged: (v) {},
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                    ]),
              ),
              Container(
                width: context.width,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Get.back();
                      try {
                        var profile = ResumeProfile(
                            id: Uuid().v4(),
                            label: controller.text.trim(),
                            pictureAsset: selectedAvatar());
                        var storage = GetStorage();
                        storage.write(profile.id, resumeProfileToJson(profile));
                        Get.toNamed(Routes.RESUME_PROFILE_FORM,
                            arguments: profile);
                      } catch (err) {
                        snack(msg: 'Something is wrong', type: SnackType.Error);
                        logger.e(err);
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create Profile"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ]),
      ),
    );
  }
}
