import 'package:flutter/material.dart';

import '../const/value.dart';

class ThemeCustom {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: mainColors_light,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.black,
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
    ),
    textTheme: const TextTheme(
      titleSmall: title_login_light,
      titleMedium: title_medium_light,
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: mainColors_dark,
    primaryColorLight: Colors.black,
    primaryColorDark: Colors.white,
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
    ),
    textTheme: const TextTheme(
      titleSmall: title_login_dark,
      titleMedium: title_medium_dark,
    ),
  );
}

// theme color light
const Color mainColors_light = Color(0xFF027335);
const Color secondColors_light = Colors.white;
const Color TextColors_light = Colors.white;
// theme color dark
const Color mainColors_dark = Color(0xFFF99B06);

const Color secondColors_dark = Colors.black;
const Color TextColors_dart = Colors.black;

const TextStyle title_login_light = TextStyle(
  color: TextColors_light,
);
const TextStyle title_login_dark = TextStyle(
  color: TextColors_dart,
);

const TextStyle title_medium_light = TextStyle(
  color: TextColors_light,
  fontSize: 24,
  fontWeight: FontWeight.w700,
);
const TextStyle title_medium_dark = TextStyle(
  color: TextColors_dart,
  fontSize: 24,
  fontWeight: FontWeight.w700,
);
