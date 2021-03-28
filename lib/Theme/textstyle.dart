import 'dart:ui';

import 'package:NewsApp/Theme/customtheme.dart';
import 'package:NewsApp/config.dart';
import 'package:flutter/material.dart';
import './colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static final appBartitle = TextStyle(
      fontSize: 20,
      color: !CustomTheme.isDarkTheme
          ? AppColor.bgColorDark
          : AppColor.bgColorLight);
  static final cardTitle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: !CustomTheme.isDarkTheme
          ? AppColor.bgColorDark
          : AppColor.bgColorLight);
}
