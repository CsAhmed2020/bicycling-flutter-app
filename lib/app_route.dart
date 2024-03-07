import 'package:flutter/material.dart';


class AppRoute {
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static final Map<String, Widget Function(BuildContext)> routes = {
    /*SplashScreen.routeName: (ctx) => SplashScreen(),
    LoginScreen.routeName: (ctx) => LoginScreen(),
    SignUpScreen.routeName: (ctx) => SignUpScreen(),*/
  };
}
