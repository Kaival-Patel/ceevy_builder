import 'package:flutter/cupertino.dart';

class OnboardingModel {
  String assetPath;
  Alignment alignment;
  double height;
  double width;
  BorderRadius radius;
  Color bgCurveColor;
  String title;
  String description;
  OnboardingModel(
      {required this.assetPath,
      required this.bgCurveColor,
      required this.alignment,
      required this.height,
      required this.width,
      required this.radius,
      required this.title,
      required this.description});
}
