import 'package:denshihanbai/apps/const/value.dart';
import 'package:denshihanbai/pages/auth/sign_in_page.dart';
import 'package:denshihanbai/pages/home/home_page.dart';
import 'package:denshihanbai/provider/data_provider.dart';
import 'package:denshihanbai/provider/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/introduction_page.dart';

class RootPage extends StatefulWidget {
  RootPage({
    super.key,
    this.numberIntro = 0,
  });
  int numberIntro;
  bool isLogin = false;

  @override
  State<RootPage> createState() => _RootPageState();
}

void readkeepSignIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int counter = prefs.getInt(prefsIntroduction) ?? 0;
  final bool keepSignIn = prefs.getBool(prefsKeepSignIn) ?? false;
  if (!keepSignIn) {
    await FirebaseAuth.instance.signOut();
  }
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    readkeepSignIn();
    context.read<DataProvider>().changeIstro(widget.numberIntro);
    if (FirebaseAuth.instance.currentUser != null) {
      // signed in
      widget.isLogin = true;
      context.read<FirebaseProvider>().getUserInfo();
    } else {
      // signed out
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int number = context.watch<DataProvider>().isIntroduction;
    if (number == 0) return const IntroductionPage();
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null) {
              context.read<FirebaseProvider>().cleanUserInfo();
              return const SignInPage();
            }
            // context.read<FirebaseProvider>().getFirebaseUserInfo('toannn');
            return HomePage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
