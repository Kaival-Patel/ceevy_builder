import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pdf;

abstract class Resume {
  String get resumeTitle;
  Widget get bodyWidget;
  String get displayAsset;
  pdf.Document get pdfDocument;
}
