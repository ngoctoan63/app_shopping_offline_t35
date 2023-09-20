import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool _isLightMode = true;

  void setMode(bool lightMode) {
    _isLightMode = lightMode;
    themeChanged(_isLightMode);
    notifyListeners();
  }

  bool get isLightMode => _isLightMode;
  void themeChanged(bool isLight) {
    if (isLight) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    // notifyListeners();
  }
}
