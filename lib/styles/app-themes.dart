import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_builder/styles/app-colors.dart';

class AppThemes {
  static String fontFamily = 'Gilroy';
  static ThemeData lightTheme = ThemeData(
      fontFamily: fontFamily,
      primaryColor: AppColors.primary,
      accentColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.scaffold,
      brightness: Brightness.light);
}
