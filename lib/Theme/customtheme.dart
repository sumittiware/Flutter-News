import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme {
    return _isDarkTheme;
  }

  bool toggleTheme() {
    _isDarkTheme = !_isDarkTheme;

    notifyListeners();
    return _isDarkTheme;
  }
}
