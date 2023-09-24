import 'package:denshihanbai/apps/const/value.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool _isLightMode = true;
  String userName = "Luis A.";
  int isIntroduction = 0;
  int notifyCount = 0;
  List<String> categoriesList = [
    'fruits',
    'vegetables',
    'bakery',
    'dairy',
    'mushroom',
    'fish',
    'pizzas',
    'chicken'
  ];

  void changeIstro(int value) {
    isIntroduction = value;
  }

  bool get isLightMode => _isLightMode;

  void setMode(bool lightMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int counter = prefs.getInt(prefsIntroduction) ?? 0;
    // final bool keepSignIn = prefs.getBool(prefsKeepSignIn) ?? false;
    // if (!keepSignIn) {
    //   await FirebaseAuth.instance.signOut();
    // }
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
