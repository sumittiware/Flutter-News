import 'package:flutter/material.dart';

import 'colors.dart';

var lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryLight,
    accentColor: AppColor.accentLight,
    //set the bg color of each scaffold widget in flutter
    scaffoldBackgroundColor: AppColor.bgColorLight,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonLight,
      shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.accent,
    ));

var darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryDark,
    accentColor: AppColor.accentDark,
    scaffoldBackgroundColor: AppColor.bgColorDark,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonDark,
      shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.accent,
    ));
