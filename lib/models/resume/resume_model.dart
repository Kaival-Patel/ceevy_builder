import 'package:flutter/cupertino.dart';

class ResumeModel {
  String thumbnailAsset;
  String title;
  String categoryId;
  Widget? resumeWidget;
  ResumeModel(
      {required this.thumbnailAsset,
      required this.title,
      required this.categoryId,
      this.resumeWidget});
}
