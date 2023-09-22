import 'package:denshihanbai/provider/auth_provider.dart';
import 'package:denshihanbai/provider/data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:denshihanbai/pages/auth/sign_in_page.dart';
import 'package:denshihanbai/pages/home/home_page.dart';
import 'package:provider/provider.dart';

import '../pages/home/introduction_page.dart';

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

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    context.read<DataProvider>().changeIstro(widget.numberIntro);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        widget.isLogin = true;
        context.read<AuthProvider>().email = user.email!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int number = context.watch<DataProvider>().isIntroduction;

    if (number == 0) return const IntroductionPage();
    if (widget.isLogin) {
      return const HomePage();
    } else {
      return const SignInPage();
    }
  }
}
