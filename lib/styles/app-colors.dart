import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

class AppColors {
  static const Color lightBlue = Color(0xFFA8CEF3);
  static const Color lightYellow = Color(0xFFFBEAB4);
  static const Color lightBlueAccent = Color(0xFFB4E8F9);
  static const Color accent = Color(0xFF37C3FF);
  static const Color primary = Color(0xFF00074A);
  static const Color scaffold = Color(0xFFF4F4F4);

  static PdfColor getPdfColor(Color color) => PdfColor.fromHex(
      '#${(color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}');
}
