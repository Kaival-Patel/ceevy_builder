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

class InfernoPdf {
  static Future<Page> getPage(
      {required ResumeProfile resumeProfile, TtfFont? font}) async {
    Uint8List userImage = resumeProfile.isAssetPath
        ? (await rootBundle.load(resumeProfile.pictureAsset))
        .buffer
        .asUint8List()
        : await File(resumeProfile.pictureAsset).readAsBytes();
    TtfFont parsedNormalFont =
    await fontFromAssetBundle('assets/fonts/Gilroy-Regular.ttf');
    TtfFont parsedBoldFont =
    await fontFromAssetBundle('assets/fonts/Gilroy-Bold.ttf');
    TextStyle lbodyStyle = TextStyle(
        fontSize: 9,
        color: AppColors.getPdfColor(m.Colors.white),
        fontNormal: Font.ttf(parsedNormalFont.data));
    TextStyle lmedStyle = TextStyle(
        fontSize: 11,
        color: AppColors.getPdfColor(m.Colors.white),
        fontWeight: FontWeight.bold,
        fontNormal: Font.ttf(parsedNormalFont.data));
    TextStyle lheadStyle = TextStyle(
        fontSize: 13,
        color: AppColors.getPdfColor(m.Colors.white),
        fontBold: Font.ttf(parsedBoldFont.data),
        fontWeight: FontWeight.bold);
    TextStyle dheadStyle = TextStyle(
        fontSize: 13,
        color: AppColors.getPdfColor(m.Color(0xFF434343)),
        fontBold: Font.ttf(parsedBoldFont.data),
        fontWeight: FontWeight.bold);
    TextStyle dmedStyle = TextStyle(
        fontSize: 11,
        color: AppColors.getPdfColor(m.Color(0xFF434343)),
        fontWeight: FontWeight.bold,
        fontNormal: Font.ttf(parsedNormalFont.data));
    TextStyle dbodyStyle = TextStyle(
      fontSize: 9,
      color: AppColors.getPdfColor(m.Color(0xFF434343)),
      fontBold: Font.ttf(parsedNormalFont.data),
    );
    return Page(
      pageFormat: PdfPageFormat.a4,
      margin: EdgeInsets.all(0),
      build: (Context context) {
        return Row(children: [
          Expanded(
              flex: 1,
              child: Container(
                  color: AppColors.getPdfColor(m.Color(0xFF434343)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Center(
                          child: ClipOval(
                              child: Container(
                                  height: 90,
                                  width: 90,
                                  color: AppColors.getPdfColor(
                                      m.Colors.orange[100]!),
                                  child: ClipOval(
                                      child: Image(MemoryImage(userImage),
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.cover)))),
                        ),
                        SizedBox(height: 25),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text("ABOUT ME",
                                style: lbodyStyle.copyWith(
                                    fontSize: lheadStyle.fontSize))),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(resumeProfile.sumamryDetails.introduction,
                              style: lbodyStyle),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                              color:
                              AppColors.getPdfColor(m.Colors.grey[700]!)),
                        ),
                        SizedBox(height: 25),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text("CONTACTS", style: lheadStyle)),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Phone", style: lmedStyle),
                                  Text(resumeProfile.personalDetails.contact,
                                      style: lbodyStyle),
                                  SizedBox(height: 3),
                                  Text("Email", style: lmedStyle),
                                  Text(resumeProfile.personalDetails.email,
                                      style: lbodyStyle),
                                  SizedBox(height: 3),
                                  Text("Address", style: lmedStyle),
                                  Text(resumeProfile.personalDetails.address,
                                      style: lbodyStyle),
                                  SizedBox(height: 3),
                                ])),
                        SizedBox(height: 25),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text("SKILLS", style: lheadStyle)),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: resumeProfile.skillDetails
                                    .map((e) => Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: Text("• ${e.title}",
                                        style: lbodyStyle)))
                                    .toList())),
                      ]))),
          Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text("${resumeProfile.personalDetails.name}",
                            style: dheadStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                        SizedBox(height: 3),
                        Text("${resumeProfile.personalDetails.positionTitle}",
                            style: dbodyStyle),
                        SizedBox(height: 10),
                        if (resumeProfile.workDetails.isNotEmpty) ...[
                          Divider(color: AppColors.getPdfColor(m.Colors.grey)),
                          SizedBox(height: 10),
                          Text("WORK EXPERIENCE", style: dheadStyle),
                          SizedBox(height: 5),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                i < resumeProfile.workDetails.length;
                                i++)
                                  Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  resumeProfile
                                                      .workDetails[i].place,
                                                  style: dmedStyle),
                                              Text(
                                                  resumeProfile
                                                      .workDetails[i].time,
                                                  style: dbodyStyle),
                                            ]),),
                                        SizedBox(width: 30),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      resumeProfile
                                                          .workDetails[i].title,
                                                      style: dmedStyle),
                                                  for (int j = 0;
                                                  j <
                                                      resumeProfile
                                                          .workDetails[i]
                                                          .experience
                                                          .length;
                                                  j++)
                                                    Text(
                                                        resumeProfile.workDetails[i]
                                                            .experience[j],
                                                        style: dbodyStyle),
                                                  SizedBox(height: 10),
                                                ]))
                                      ]),
                                SizedBox(height: 10),
                              ])
                        ],
                        if (resumeProfile.education.isNotEmpty) ...[
                          Divider(color: AppColors.getPdfColor(m.Colors.grey)),
                          SizedBox(height: 10),
                          Text("EDUCATION", style: dheadStyle),
                          SizedBox(height: 5),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                i < resumeProfile.education.length;
                                i++)
                                  Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    resumeProfile
                                                        .education[i].place,
                                                    style: dmedStyle),
                                                Text(
                                                    resumeProfile
                                                        .education[i].time,
                                                    style: dbodyStyle),
                                              ]),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      resumeProfile
                                                          .education[i].title,
                                                      style: dmedStyle),
                                                ])
                                        )
                                      ])
                              ])
                        ]
                      ]))),
        ]);
      },
    );
  }
}
