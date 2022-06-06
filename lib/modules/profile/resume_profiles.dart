import 'package:flutter/material.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:get/get.dart';

class ResumeProfiles extends StatelessWidget {
  const ResumeProfiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style:
                    TextStyle(fontSize: 12, color: context.theme.disabledColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: context.width * 0.7,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text('Create Resume Profile'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
