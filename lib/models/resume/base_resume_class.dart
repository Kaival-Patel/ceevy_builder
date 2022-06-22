import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:resume_builder/models/profile/resume_profile_model.dart';

abstract class Resume {
  String get resumeTitle;
  Widget get bodyWidget;
  String get displayAsset;
  pdf.Page pdfDocument(ResumeProfile profile);
}
