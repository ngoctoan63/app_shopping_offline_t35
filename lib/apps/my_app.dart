import 'package:denshihanbai/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:denshihanbai/apps/routers/router.dart';
import 'package:denshihanbai/apps/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home/introduction_page.dart';
import 'routers/router_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print("------get OS theme mode");
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    print(isDarkMode);
    checkFirstSeen();
    return ChangeNotifierProvider(
        create: (context) => DataProvider()..setMode(!isDarkMode),
        child: const App());
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    print("Check first run $seen");
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
    print("---------ccc-38");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("App state:$state");
    if (state == AppLifecycleState.inactive) {
      // context.read<DataProvider>().saveData();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build my app!!!!");
    return Consumer<DataProvider>(
        builder: (context, value, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeCustom.lightTheme,
              darkTheme: ThemeCustom.darkTheme,
              themeMode: value.themeMode,
              onGenerateRoute: RouterCustom.onGenerateRoute,
              // initialRoute: value.isFistRun
              //     ? RouterName.introductionPage
              //     : RouterName.signInPage,
              home: const IntroductionPage(),
            ));
  }
}
