import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackType { Info, Success, Error }

void snack({required String msg, SnackType type = SnackType.Info}) {
  Get.snackbar(parseStringFromSnackType(type), msg,
      icon: Icon(
        parseSnackType(type),
        color: Colors.white,
      ),
      backgroundColor: parseColorFromSnackType(type),
      barBlur: 0,
      colorText: Colors.white,
      shouldIconPulse: false,
      margin: EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM);
}

String parseStringFromSnackType(SnackType type) {
  switch (type) {
    case SnackType.Info:
      return "Info";
    case SnackType.Success:
      return "Success";
    case SnackType.Error:
      return "Error";
  }
}

Color parseColorFromSnackType(SnackType type) {
  switch (type) {
    case SnackType.Info:
      return Colors.blue;
    case SnackType.Success:
      return Colors.green;
    case SnackType.Error:
      return Colors.red;
  }
}

IconData parseSnackType(SnackType type) {
  switch (type) {
    case SnackType.Info:
      return Icons.info_outlined;
    case SnackType.Success:
      return Icons.check_circle_outlined;
    case SnackType.Error:
      return Icons.error_outline_outlined;
    default:
      return Icons.info_outlined;
  }
}
