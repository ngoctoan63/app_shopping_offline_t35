import 'package:denshihanbai/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:denshihanbai/apps/routers/router.dart';
import 'package:denshihanbai/apps/routers/router_name.dart';
import 'package:denshihanbai/apps/themes/theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataProvider(), child: const App());
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
              initialRoute: RouterName.rootPage,
              onGenerateRoute: RouterCustom.onGenerateRoute,
            ));
  }
}
