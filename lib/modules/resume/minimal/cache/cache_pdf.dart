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

class CachePdf {
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
    TextStyle dheadStyle = TextStyle(
        fontSize: 15,
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
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 35),
                            ClipRRect(
                                verticalRadius: 5,
                                horizontalRadius: 5,
                                child: Image(MemoryImage(userImage),
                                    height: 90, width: 90, fit: BoxFit.cover)),
                            SizedBox(height: 20),
                            Text("EDUCATION", style: dheadStyle),
                            SizedBox(height: 10),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: resumeProfile.education
                                    .map((e) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                  child: Text("${e.title}",
                                                      style: dbodyStyle.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontBold:
                                                              parsedBoldFont))),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3),
                                                  child: Text("${e.place}",
                                                      style: dbodyStyle)),
                                            ]))
                                    .toList()),
                            SizedBox(height: 10),
                            Divider(
                                color:
                                    AppColors.getPdfColor(m.Colors.grey[100]!)),
                            SizedBox(height: 5),
                            Text("SKILLS", style: dheadStyle),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: resumeProfile.skillDetails
                                    .map((e) => Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: Text("${e.title}",
                                        style: dbodyStyle)))
                                    .toList()),
                            SizedBox(height: 10),
                            Divider(
                                color:
                                AppColors.getPdfColor(m.Colors.grey[100]!)),
                            SizedBox(height: 10),
                            Text("CONTACT", style: dheadStyle),
                            SizedBox(height: 5),
                            Text('Address',
                                style: dbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontBold: parsedBoldFont)),
                            SizedBox(height: 2),
                            Text(resumeProfile.personalDetails.address,
                                style: dbodyStyle),
                            SizedBox(height: 5),
                            Text('Phone',
                                style: dbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontBold: parsedBoldFont)),
                            SizedBox(height: 2),
                            Text(resumeProfile.personalDetails.contact,
                                style: dbodyStyle),
                            SizedBox(height: 5),
                            Text('Email',
                                style: dbodyStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontBold: parsedBoldFont)),
                            SizedBox(height: 2),
                            Text(resumeProfile.personalDetails.email,
                                style: dbodyStyle),
                            SizedBox(height: 10),
                          ])))),
          VerticalDivider(color: AppColors.getPdfColor(m.Colors.white30)),
          Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35),
                        Text("${resumeProfile.personalDetails.name}",
                            style: dheadStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 19)),
                        Text("${resumeProfile.personalDetails.positionTitle}",
                            style: dbodyStyle.copyWith(fontWeight: FontWeight.bold,fontBold: parsedBoldFont)),
                        SizedBox(height: 5),
                        Text("${resumeProfile.sumamryDetails.introduction}",
                            style: dbodyStyle),
                        SizedBox(height: 5),
                        if (resumeProfile.workDetails.isNotEmpty) ...[
                          SizedBox(height: 10),
                          Text("MY EXPERIENCE", style: dheadStyle),
                          SizedBox(height: 5),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < resumeProfile.workDetails.length;
                                    i++)
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            resumeProfile.workDetails[i].title,
                                            style: dmedStyle),
                                        Text(
                                            resumeProfile
                                                .workDetails[i].time,
                                            style: dbodyStyle),
                                        Text(
                                            resumeProfile
                                                .workDetails[i].place,
                                            style: dbodyStyle.copyWith(
                                                fontItalic:
                                                    parsedItalicFont)),
                                        SizedBox(height: 5),
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
                                        SizedBox(height: 10)
                                      ]),
                                SizedBox(height: 10),
                              ])
                        ],
                      ]))),
        ]);
      },
    );
  }
}
