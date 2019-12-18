import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/material.dart';
import 'package:exchanger2/values/colors.dart';

class Themes {
  static final MAIN_THEME = ThemeData(
    accentColor: AppColors.ALADDIN_SUGAR,
    appBarTheme: AppBarTheme(
      color: AppColors.DARK_PUPLE_BLUE,
      textTheme: TextTheme(
        body1: TextStyle(fontFamily: 'main'),
        body2: TextStyle(fontFamily: 'main'),
        title: TextStyle(fontFamily: 'main' , fontSize: 25),
      ),
    ),
    primaryColor: AppColors.DARK_PUPLE_BLUE,
    canvasColor: AppColors.DARK_PUPLE_BLUE,
    cardColor: AppColors.ALADDIN_WHITE,
    cursorColor: AppColors.ALADDIN_ZERESHKI,
    dividerColor: AppColors.BLACK,
    textTheme: TextTheme(
      body1: TextStyle(fontFamily: 'main'),
      body2: TextStyle(fontFamily: 'main'),
      title: TextStyle(fontFamily: 'main'),
      subhead: TextStyle(fontFamily: 'main'),
      subtitle: TextStyle(fontFamily: 'main'),
      button: TextStyle(
        fontFamily: 'main',
      ),
    ),
  );
}
