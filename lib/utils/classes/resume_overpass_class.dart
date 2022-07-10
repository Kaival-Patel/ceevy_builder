import 'package:pdf/src/widgets/document.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:resume_builder/models/profile/resume_profile_model.dart';
import 'package:resume_builder/models/resume/base_resume_class.dart';
import 'package:resume_builder/modules/resume/modern/mirage/mirage.dart';
import 'package:resume_builder/modules/resume/modern/mirage/mirage_pdf.dart';
import 'package:resume_builder/modules/resume/professional/overpass/overpass.dart';
import 'package:resume_builder/modules/resume/professional/overpass/overpass_pdf.dart';
import 'package:resume_builder/modules/resume/simple/aztec/aztec.dart';
import 'package:resume_builder/modules/resume/simple/aztec/aztec_pdf.dart';
import 'package:resume_builder/styles/app-assets.dart';

class OverpassResume implements Resume {
  @override
  // TODO: implement bodyWidget
  Widget bodyWidget(ResumeProfile profile) =>Overpass(
    resumeProfile:
    profile.isValid ? profile : ResumeProfile().defaultProfile,
  );

  @override
  // TODO: implement displayAsset
  String get displayAsset => AppAssets.pro_ct;

  @override
  // TODO: implement pdfDocument
  Future<p.Page> pdfDocument(ResumeProfile profile, {p.TtfFont? font}) async =>
      await OverpassPdf.getPage(
          resumeProfile:
          profile.isValid ? profile : ResumeProfile().defaultProfile,
          font: font);

  @override
  // TODO: implement resumeTitle
  String get resumeTitle => 'Overpass';
}
