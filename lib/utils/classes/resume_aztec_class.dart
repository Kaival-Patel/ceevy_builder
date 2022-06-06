import 'package:pdf/src/widgets/document.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resume_builder/models/resume/base_resume_class.dart';
import 'package:resume_builder/modules/resume/simple/aztec/aztec.dart';
import 'package:resume_builder/styles/app-assets.dart';

class AztecResume implements Resume {
  @override
  // TODO: implement bodyWidget
  Widget get bodyWidget => Aztec();

  @override
  // TODO: implement displayAsset
  String get displayAsset => AppAssets.simple_ct;

  @override
  // TODO: implement pdfDocument
  Document get pdfDocument => throw UnimplementedError();

  @override
  // TODO: implement resumeTitle
  String get resumeTitle => 'Aztec';
}
