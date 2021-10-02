import 'package:colgate/utils/config/app_colors.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: AppColors.appColor,
  accentColor: AppColors.appColor,
  splashColor: Color(0xff71B6BC),
  fontFamily: AppConfig.appFontFamily,
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);
