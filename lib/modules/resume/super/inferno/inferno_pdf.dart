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
    TtfFont parsedItalicFont =
        await fontFromAssetBundle('assets/fonts/Gilroy-Italic.ttf');
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
        fontSize: 20,
        color: AppColors.getPdfColor(m.Colors.white),
        fontBold: Font.ttf(parsedBoldFont.data),
        fontWeight: FontWeight.bold);
    TextStyle dheadStyle = TextStyle(
        fontSize: 17,
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
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 1,
              child: Container(
                  color: AppColors.getPdfColor(m.Color(0xFF346494)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(resumeProfile.personalDetails.name,
                                      style: lheadStyle),
                                  Text(
                                      resumeProfile
                                          .personalDetails.positionTitle,
                                      style: lmedStyle.copyWith(
                                          color: AppColors.getPdfColor(
                                              m.Colors.grey[200]!))),
                                ])),
                        SizedBox(height: 20),
                        Container(
                            height: 20,
                            width: double.infinity,
                            color: AppColors.getPdfColor(m.Color(0xFF043a71)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child:
                                    Text("Personal Info", style: lmedStyle))),
                        SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Address',
                                style: lbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontBold: parsedBoldFont))),
                        SizedBox(height: 2),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(resumeProfile.personalDetails.address,
                              style: lbodyStyle),
                        ),
                        SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Phone',
                                style: lbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontBold: parsedBoldFont))),
                        SizedBox(height: 2),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(resumeProfile.personalDetails.contact,
                              style: lbodyStyle),
                        ),
                        SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Email',
                                style: lbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontBold: parsedBoldFont))),
                        SizedBox(height: 2),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(resumeProfile.personalDetails.email,
                              style: lbodyStyle),
                        ),
                        SizedBox(height: 10),
                        Container(
                            height: 20,
                            width: double.infinity,
                            color: AppColors.getPdfColor(m.Color(0xFF043a71)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Text("Skills", style: lmedStyle))),
                        SizedBox(height: 5),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
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
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Text("${resumeProfile.sumamryDetails.introduction}",
                            style: dbodyStyle),
                        SizedBox(height: 5),
                        if (resumeProfile.workDetails.isNotEmpty) ...[
                          Divider(color: AppColors.getPdfColor(m.Colors.grey)),
                          Text("Work Experience", style: dmedStyle),
                          Divider(color: AppColors.getPdfColor(m.Colors.grey)),
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
                                        Expanded(
                                          child: Text(
                                              resumeProfile.workDetails[i].time,
                                              style: dbodyStyle),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      resumeProfile
                                                          .workDetails[i].title,
                                                      style: dmedStyle),
                                                  Text(
                                                      resumeProfile
                                                          .workDetails[i].place,
                                                      style: dbodyStyle.copyWith(
                                                          fontItalic:
                                                              parsedItalicFont)),
                                                  SizedBox(height: 2),
                                                  for (int j = 0;
                                                      j <
                                                          resumeProfile
                                                              .workDetails[i]
                                                              .experience
                                                              .length;
                                                      j++)
                                                    Text(
                                                        "- " +
                                                            resumeProfile
                                                                .workDetails[i]
                                                                .experience[j],
                                                        style: dbodyStyle),
                                                  SizedBox(height: 10),
                                                ]))
                                      ]),
                                SizedBox(height: 10),
                              ])
                        ],
                        if (resumeProfile.education.isNotEmpty) ...[
                          SizedBox(height: 20),
                          Divider(color: AppColors.getPdfColor(m.Colors.grey)),
                          Text("Education", style: dmedStyle),
                          Divider(color: AppColors.getPdfColor(m.Colors.grey)),
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
                                          child: Text(
                                              resumeProfile.education[i].time,
                                              style: dbodyStyle),
                                        ),
                                        SizedBox(width: 30),
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      resumeProfile
                                                          .education[i].title,
                                                      style: dmedStyle),
                                                  Text(
                                                      resumeProfile
                                                          .education[i].place,
                                                      style: dbodyStyle),
                                                ]))
                                      ]),
                                SizedBox(height: 30),
                              ])
                        ]
                      ]))),
        ]);
      },
    );
  }
}
