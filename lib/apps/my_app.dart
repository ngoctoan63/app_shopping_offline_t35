import 'package:flutter/material.dart';
import 'package:denshihanbai/apps/routers/router.dart';
import 'package:denshihanbai/apps/routers/router_name.dart';
import 'package:denshihanbai/apps/themes/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeCustom.lightTheme,
      darkTheme: ThemeCustom.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: RouterName.rootPage,
      onGenerateRoute: RouterCustom.onGenerateRoute,
    );
  }
}
