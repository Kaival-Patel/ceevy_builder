import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/modules/create-profile/create_profile.dart';
import 'package:resume_builder/modules/profile/resume_profile_controller.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:get/get.dart';

class ResumeProfiles extends StatelessWidget {
  ResumeProfiles({Key? key}) : super(key: key);
  var c = Get.put(ResumeProfilesController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.resumeProfileMap.isEmpty) {
        return Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    AppAssets.no_profiles,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'No Resume Profile, Lets create one to get started',
                    style: TextStyle(
                        fontSize: 12, color: context.theme.disabledColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: context.width * 0.7,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.bottomSheet(CreateProfile(),
                            isScrollControlled: true);
                      },
                      child: Center(
                        child: Text('Create Resume Profile'),
                      )),
                )
              ],
            ),
          ),
        );
      } else {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListView.builder(
            itemBuilder: (context, index) => ProfileCard(
                profile: c.resumeProfileMap.values.elementAt(index)),
            shrinkWrap: true,
            itemCount: c.resumeProfileMap.length,
            physics: NeverScrollableScrollPhysics(),
          ),
        );
      }
    });
  }
}

class ProfileCard extends StatelessWidget {
  ResumeProfile profile;
  ProfileCard({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: context.theme.disabledColor, width: 0.5)),
          child: ClipOval(
            child: Image.asset(
              height: 50,
              width: 50,
              profile.pictureAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.label,
                  style: context.textTheme.headline6,
                )
              ]),
        ),
        SizedBox(
          width: 5,
        ),
        Row(
          children: [
            SvgPicture.asset(AppAssets.editIcon, height: 20, width: 20),
          ],
        ),
        SizedBox(
          width: 5,
        ),
      ]),
    );
  }
}
