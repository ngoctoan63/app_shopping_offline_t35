import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:denshihanbai/apps/root_page.dart';
import 'package:denshihanbai/apps/routers/router_name.dart';
import 'package:denshihanbai/pages/error/error_page.dart';
import 'package:denshihanbai/pages/home/home_page.dart';

import '../../pages/auth/create_account_page.dart';
import '../../pages/auth/sign_in_page.dart';

class RouterCustom {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.rootPage:
        return page(const RootPage());
      case RouterName.homePage:
        return page(const HomePage());
      case RouterName.signInPage:
        return page(const SignInPage());
      case RouterName.createAccountPage:
        return page(const CreateAccount());
      default:
        return _errorPage();
    }
  }

  static _errorPage() {
    page(const ErrorPage());
  }

  static PageTransition<dynamic> page(Widget routerPage) =>
      PageTransition(child: routerPage, type: PageTransitionType.fade);
}
