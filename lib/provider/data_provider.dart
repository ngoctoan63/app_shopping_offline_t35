import 'package:denshihanbai/apps/const/value.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool _isLightMode = true;
  String userName = "Luis A.";
  int isIntroduction = 0;
  int notifyCount = 0;
  void changeIstro(int value) {
    isIntroduction = value;
  }

  bool get isLightMode => _isLightMode;

  void setMode(bool lightMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int counter = prefs.getInt(introduction) ?? 0;
    isIntroduction = counter;
    _isLightMode = lightMode;
    themeChanged(_isLightMode);
    notifyListeners();
  }

  void themeChanged(bool isLight) {
    themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
    // notifyListeners();
  }
}
