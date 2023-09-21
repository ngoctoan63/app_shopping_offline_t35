import 'package:flutter/material.dart';
import 'package:denshihanbai/pages/auth/sign_in_page.dart';
import 'package:denshihanbai/pages/home/home_page.dart';

import '../pages/home/introduction_page.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key, this.isIntroducted = false});

  bool isIntroducted = false;
  @override
  Widget build(BuildContext context) {
    bool isLogin = true;
    if (!isIntroducted) {
      return const IntroductionPage();
    } else if (isLogin) {
      return const HomePage();
    } else {
      return const SignInPage();
    }
  }
}
