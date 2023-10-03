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
  List<Map<String, dynamic>> popularDeals = [
    {
      'id': 1,
      'title': 'Chicken Village',
      'price': 10.5,
      'discount': 5,
      'likeCount': 256,
      'image_path': 'image01.jpg'
    },
    {
      'id': 2,
      'title': 'Gourami Fish',
      'price': 12.5,
      'discount': 0,
      'likeCount': 75,
      'image_path': 'image02.jpg'
    },
    {
      'id': 3,
      'title': 'Tomatoes',
      'price': 17.5,
      'discount': 7,
      'likeCount': 275,
      'image_path': 'image03.jpg'
    },
    {
      'id': 4,
      'title': 'Fresh Milk',
      'price': 19.5,
      'discount': 25,
      'likeCount': 453,
      'image_path': 'image04.jpg'
    },
    {
      'id': 5,
      'title': 'Fresh Avocados',
      'price': 12.5,
      'discount': 0,
      'likeCount': 375,
      'image_path': 'image05.jpg'
    },
    {
      'id': 6,
      'title': 'Fresh Grapes',
      'price': 27.5,
      'discount': 18,
      'likeCount': 25,
      'image_path': 'image06.jpg'
    }
  ];
  void changeIstro(int value) {
    isIntroduction = value;
  }

  bool get isLightMode => _isLightMode;

  void setMode(bool lightMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int counter = prefs.getInt(prefsIntroduction) ?? 0;
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
