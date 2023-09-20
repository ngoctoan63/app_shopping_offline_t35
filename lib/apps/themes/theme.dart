import 'package:flutter/material.dart';

import '../const/value.dart';

class ThemeCustom {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: mainColors_light,
    textTheme: const TextTheme(
      titleSmall: title_login_light,
      titleMedium: title_medium_light,
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: mainColors_dark,
    textTheme: const TextTheme(
      titleSmall: title_login_dark,
      titleMedium: title_medium_dark,
    ),
  );
}

// theme color light
const Color mainColors_light = Color(0xFF027335);
const Color TextColors_light = Colors.white;
// theme color dark
const Color mainColors_dark = Color(0xFFF99B06);
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
