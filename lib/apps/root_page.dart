import 'package:flutter/material.dart';
import 'package:denshihanbai/pages/auth/sign_in_page.dart';
import 'package:denshihanbai/pages/home/home_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    if (isLogin) {
      return const HomePage();
    } else {
      return const SignInPage();
    }
  }
}
