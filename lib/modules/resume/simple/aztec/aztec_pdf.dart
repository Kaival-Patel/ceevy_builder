import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as m;
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/styles/app-colors.dart';

class AztecPdf {
  static Page getPage({required ResumeProfile resumeProfile, TtfFont? font}) {
    return Page(
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.all(10),
      build: (Context context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "${resumeProfile.personalDetails.name}",
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, font: font),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${resumeProfile.personalDetails.address}",
              style: TextStyle(
                  fontSize: 12,
                  font: font,
                  color: AppColors.getPdfColor(m.Colors.grey)),
            ),
            Divider(
              thickness: 2,
              color: AppColors.getPdfColor(Get.theme.accentColor),
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
                      "PROFESSIONAL\nSUMMARY",
                      style: TextStyle(
                          fontSize: 13,
                          font: font,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 4,
                    child: Text(
                      "${resumeProfile.sumamryDetails.introduction}",
                      style: TextStyle(fontSize: 11, font: font),
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
                      style: TextStyle(
                          fontSize: 13,
                          font: font,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: Get.width,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      spacing: 5,
                      runSpacing: 1,
                      children: resumeProfile.skillDetails
                          .map((e) => Expanded(
                                  child: Text(
                                "-" + e.title,
                                style: TextStyle(fontSize: 11, font: font),
                              )))
                          .toList(),
                    ),
                  ),
                )
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
                      "WORK HISTORY",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          font: font),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      width: Get.width,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  resumeProfile.workDetails[index].time,
                                  style: TextStyle(
                                      fontSize: 11,
                                      font: font,
                                      color: AppColors.getPdfColor(
                                          Get.theme.disabledColor)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      resumeProfile.workDetails[index].title,
                                      style: TextStyle(
                                          fontSize: 11,
                                          font: font,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " | " +
                                          resumeProfile
                                              .workDetails[index].place,
                                      style: TextStyle(
                                        fontSize: 11,
                                        font: font,
                                      ),
                                    ),
                                  ],
                                ),
                                for (int i = 0;
                                    i <
                                        resumeProfile.workDetails[index]
                                            .experience.length;
                                    i++)
                                  Text(
                                    "- " +
                                        "${resumeProfile.workDetails[index].experience[i]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      font: font,
                                    ),
                                  ),
                              ]),
                        ),
                        itemCount: resumeProfile.workDetails.length,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "EDUCATION",
                      style: TextStyle(
                          fontSize: 13,
                          font: font,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      width: Get.width,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  resumeProfile.education[index].time,
                                  style: TextStyle(
                                      fontSize: 11,
                                      font: font,
                                      color: AppColors.getPdfColor(
                                          Get.theme.disabledColor)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      resumeProfile.education[index].title,
                                      style: TextStyle(
                                          fontSize: 11,
                                          font: font,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " | " +
                                          resumeProfile.education[index].place,
                                      style: TextStyle(
                                        fontSize: 11,
                                        font: font,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        itemCount: resumeProfile.education.length,
                      )),
                )
              ],
            ),
          ]),
        );
      },
    );
  }
}
