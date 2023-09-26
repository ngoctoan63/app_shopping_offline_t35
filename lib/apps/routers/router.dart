import 'package:denshihanbai/pages/product_categories.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:denshihanbai/apps/root_page.dart';
import 'package:denshihanbai/apps/routers/router_name.dart';
import 'package:denshihanbai/pages/error/error_page.dart';
import 'package:denshihanbai/pages/home/home_page.dart';

import '../../pages/auth/create_account_page.dart';
import '../../pages/auth/sign_in_page.dart';
import '../../pages/home/introduction_page.dart';

class RouterCustom {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.rootPage:
        return page(RootPage());
      case RouterName.introductionPage:
        return page(const IntroductionPage());
      case RouterName.homePage:
        return page(const HomePage());
      case RouterName.signInPage:
        return page(const SignInPage());
      case RouterName.createAccountPage:
        return page(const CreateAccount());
      case RouterName.productCategories:
        return page(const ProductCategories());
      default:
        return _errorPage();
    }
  }

  static _errorPage() {
    page(const ErrorPage());
  }

  static PageTransition<dynamic> page(Widget routerPage) => PageTransition(
      child: routerPage,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 300));
}
