import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool _isLightMode = true;
  bool _isFistRun = true;
  String userName = "Luis A.";
  void setMode(bool lightMode) {
    _isLightMode = lightMode;
    themeChanged(_isLightMode);
    print("change theme mode");
    checkFirstSeen();
    notifyListeners();
  }

  Future checkFirstSeen() async {
    print("check firt run:");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFistRun = (prefs.getBool('seen') ?? false);
    _isFistRun = !_isFistRun;
    print("_isFistRun:");
    print(_isFistRun);
  }

  bool get isLightMode => _isLightMode;

  bool get isFistRun => _isFistRun;
  void themeChanged(bool isLight) {
    if (isLight) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    // notifyListeners();
  }
}
