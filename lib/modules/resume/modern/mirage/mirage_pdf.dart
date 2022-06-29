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
        font ?? await fontFromAssetBundle('assets/fonts/Gilroy-Regular.ttf');
    TtfFont parsedBoldFont =
        font ?? await fontFromAssetBundle('assets/fonts/Gilroy-ExtraBold.ttf');
    TextStyle bodyStyle =
        TextStyle(fontSize: 11, fontNormal: Font.ttf(parsedNormalFont.data));
    TextStyle headStyle = TextStyle(
        letterSpacing: 1.5,
        fontSize: 15,
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
                                  style: headStyle.copyWith(
                                    fontSize: 8,
                                  ),
                                ),
                              ])
                        ]),
                    SizedBox(height: 20),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("CONTACT", style: headStyle),
                                SizedBox(height: 5),
                                Text(resumeProfile.personalDetails.contact,
                                    style: bodyStyle),
                                Text(resumeProfile.personalDetails.email,
                                    style: bodyStyle),
                                Text(resumeProfile.personalDetails.address,
                                    style: bodyStyle),
                              ])),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("CONTACT",
                                        style: TextStyle(letterSpacing: 1.5)),
                                  ])),
                        ])
                  ]),
            ));
      },
    );
  }
}
