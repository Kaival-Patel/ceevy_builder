import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as m;
import 'package:printing/printing.dart';
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/styles/app-assets.dart';
import 'package:resume_builder/styles/app-colors.dart';

class MiragePdf {
  static Future<Page> getPage(
      {required ResumeProfile resumeProfile, TtfFont? font}) async {
    var bgImage = (await rootBundle.load(AppAssets.mirageResumeBg));
    Uint8List userImage = resumeProfile.isAssetPath
        ? (await rootBundle.load(resumeProfile.pictureAsset))
            .buffer
            .asUint8List()
        : await File(resumeProfile.pictureAsset).readAsBytes();
    TtfFont parsedNormalFont =
        await fontFromAssetBundle('assets/fonts/Gilroy-Regular.ttf');
    TtfFont parsedBoldFont =
        await fontFromAssetBundle('assets/fonts/Gilroy-Bold.ttf');
    TextStyle bodyStyle =
        TextStyle(fontSize: 7, fontNormal: Font.ttf(parsedNormalFont.data));
    TextStyle headStyle = TextStyle(
        letterSpacing: 1.2,
        fontSize: 11,
        fontBold: Font.ttf(parsedBoldFont.data),
        fontWeight: FontWeight.bold);
    return Page(
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.all(0),
      build: (Context context) {
        return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MemoryImage(bgImage.buffer.asUint8List()),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          ClipOval(
                              child: Image(MemoryImage(userImage),
                                  height: 90, width: 90, fit: BoxFit.cover)),
                          SizedBox(width: 100),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "${resumeProfile.personalDetails.name.toUpperCase()}",
                                  style: headStyle.copyWith(
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  "${resumeProfile.personalDetails.positionTitle.toUpperCase()}",
                                  style: bodyStyle.copyWith(
                                      fontSize: 8, letterSpacing: 1.5),
                                ),
                              ])
                        ]),
                    SizedBox(height: 45),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                //CONTACT
                                Text("CONTACT",
                                    style: bodyStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                        fontBold: parsedBoldFont)),
                                SizedBox(height: 7),
                                Text(resumeProfile.personalDetails.contact,
                                    style: bodyStyle),
                                SizedBox(height: 2),
                                Text(resumeProfile.personalDetails.email,
                                    style: bodyStyle),
                                SizedBox(height: 2),
                                Text(resumeProfile.personalDetails.address,
                                    style: bodyStyle),
                                SizedBox(height: 20),
                                //EDUCATION
                                Text("EDUCATION",
                                    style: bodyStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                        fontBold: parsedBoldFont)),
                                SizedBox(height: 7),
                                for (int index = 0;
                                    index < resumeProfile.education.length;
                                    index++)
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            resumeProfile
                                                .education[index].title,
                                            style: bodyStyle),
                                        Text(
                                            resumeProfile
                                                .education[index].place,
                                            style: bodyStyle),
                                        Text(
                                            resumeProfile.education[index].time,
                                            style: bodyStyle),
                                        SizedBox(height: 3),
                                      ]),
                                //SKILLS
                                SizedBox(height: 20),
                                Text("SKILLS",
                                    style: bodyStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                        fontBold: parsedBoldFont)),
                                SizedBox(height: 7),
                                for (int index = 0;
                                    index < resumeProfile.skillDetails.length;
                                    index++)
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "• " +
                                                resumeProfile
                                                    .skillDetails[index].title,
                                            style: bodyStyle),
                                        SizedBox(height: 3),
                                      ]),
                              ])),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //CONTACT
                                    Text("PROFILE",
                                        style: bodyStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.3,
                                            fontBold: parsedBoldFont)),
                                    SizedBox(height: 7),
                                    Text(
                                        resumeProfile
                                            .sumamryDetails.introduction,
                                        style: bodyStyle),
                                    SizedBox(height: 20),
                                    //EDUCATION
                                    Text("PROFESSIONAL EXPERIENCE",
                                        style: bodyStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.3,
                                            fontBold: parsedBoldFont)),
                                    SizedBox(height: 7),
                                    for (int index = 0;
                                        index <
                                            resumeProfile.workDetails.length;
                                        index++)
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                resumeProfile
                                                    .workDetails[index].title
                                                    .toUpperCase(),
                                                style: headStyle.copyWith(
                                                    fontSize: 6)),
                                            SizedBox(height: 1),
                                            Text(
                                                resumeProfile.workDetails[index]
                                                        .place +
                                                    " | " +
                                                    resumeProfile
                                                        .workDetails[index]
                                                        .time,
                                                style: bodyStyle),
                                            SizedBox(height: 3),
                                            for (int i = 0;
                                                i <
                                                    resumeProfile
                                                        .workDetails[index]
                                                        .experience
                                                        .length;
                                                i++)
                                              Text(
                                                  "• " +
                                                      resumeProfile
                                                          .workDetails[index]
                                                          .experience[i],
                                                  style: bodyStyle),
                                            SizedBox(height: 0.5),
                                            SizedBox(height: 3),
                                          ]),
                                  ])),
                        ])
                  ]),
            ));
      },
    );
  }
}
