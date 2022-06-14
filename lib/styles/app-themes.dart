import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resume_builder/styles/app-colors.dart';

class AppThemes {
  static String fontFamily = 'Gilroy';
  static ThemeData lightTheme = ThemeData(
      fontFamily: fontFamily,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              primary: AppColors.accent,
              minimumSize: Size.fromHeight(45),
              textStyle: TextStyle(
                  color: Colors.white, fontFamily: 'Gilroy', fontSize: 16))),
      primaryColor: AppColors.primary,
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffold,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontSize: 16),
          centerTitle: true),
      accentColor: AppColors.accent,
      scaffoldBackgroundColor: AppColors.scaffold,
      hoverColor: Colors.grey[300],
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headline4: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      brightness: Brightness.light);
}
