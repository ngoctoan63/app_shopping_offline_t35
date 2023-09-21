import 'package:denshihanbai/provider/data_provider.dart';
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

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    context.read<DataProvider>().changeIstro(widget.numberIntro);
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    int number = context.watch<DataProvider>().isIntroduction;

    if (number == 0) return const IntroductionPage();
    if (isLogin) {
      return const HomePage();
    } else {
      return const SignInPage();
    }
  }
}
