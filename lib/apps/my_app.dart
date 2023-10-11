import 'package:denshihanbai/apps/routers/router.dart';
import 'package:denshihanbai/apps/themes/theme.dart';
import 'package:denshihanbai/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/firebase_provider.dart';
import 'const/value.dart';
import 'routers/router_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DataProvider()..setMode(!isDarkMode)),
        ChangeNotifierProvider(
          create: (_) => FirebaseProvider(),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(prefsIntroduction, 1);
    }
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeCustom.lightTheme,
          darkTheme: ThemeCustom.darkTheme,
          themeMode: value.themeMode,
          initialRoute: RouterName.rootPage,
          onGenerateRoute: RouterCustom.onGenerateRoute,
          builder: FToastBuilder()
          // home: const ProductCategories(),
          ),
    );
  }
}
