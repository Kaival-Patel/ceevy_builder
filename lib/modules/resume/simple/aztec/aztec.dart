import 'package:flutter/material.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/resume_model.dart';
import 'package:get/get.dart';

class Aztec extends StatelessWidget {
  ResumeProfile resumeProfile;
  Aztec({required this.resumeProfile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "${resumeProfile.personalDetails.name.toUpperCase()}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "${resumeProfile.personalDetails.address}",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Divider(
          thickness: 2,
          color: context.theme.accentColor,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  "PROFESSIONAL SUMMARY",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 4,
                child: Text(
                  "${resumeProfile.sumamryDetails.introduction}",
                  style: TextStyle(fontSize: 11),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "SKILLS",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: context.width,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 1,
                  children: resumeProfile.skillDetails
                      .map((e) => Expanded(
                              child: Text(
                            "-" + e.title,
                            style: TextStyle(fontSize: 11),
                          )))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
