import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/modules/create-profile/create_profile.dart';
import 'package:resume_builder/styles/app-assets.dart';

class CreateProfileSuggestion extends StatelessWidget {
  CreateProfileSuggestion({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.theme.scaffoldBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(AppAssets.profiles),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'Create Resume with Profiles',
                  style: context.textTheme.headline6,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                      'Make resume with all the details covered by making your resume profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: context.theme.disabledColor)),
                ),
                SizedBox(
                  height: 5,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Skip")),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            await Get.bottomSheet(CreateProfile(),
                                isScrollControlled: true);
                          },
                          child: Text('Create Profile')),
                    )
                  ],
                ),
                // Container(
                //   height: 50,
                //   width: context.width,
                //   child: Row(
                //     children: [
                //       TextButton(onPressed: () {}, child: Text("Skip")),
                // ElevatedButton(
                //     onPressed: () {}, child: Text('Create Profile'))
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
              ]),
        ),
      ),
    );
  }
}
