import 'package:flutter/material.dart';
import 'colors.dart';

class CustomTheme with ChangeNotifier {
  static bool isDarkTheme = false;
  ThemeMode get currentTheme => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
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
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.primaryDark,
        accentColor: AppColor.accentDark,
        scaffoldBackgroundColor: AppColor.bgColorDark,
        buttonTheme: ButtonThemeData(
          buttonColor: AppColor.buttonDark,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.accent,
        ));
  }
}
