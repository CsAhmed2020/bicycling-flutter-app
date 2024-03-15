import 'package:bicycling_app/features/auth/login/screen/login_screen.dart';
import 'package:bicycling_app/features/auth/signup/screen/sign_up_screen.dart';
import 'package:bicycling_app/features/navigation_drawer/screen/navigation_drawer_screen.dart';
import 'package:bicycling_app/features/welcome_screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'features/welcome_screens/onboarding/onboarding_screen.dart';



class AppRoute {
  static final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static final Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.routeName: (ctx) => SplashScreen(),
    OnBoardingScreen.routeName: (ctx) => const OnBoardingScreen(),
    LoginScreen.routeName: (ctx) => LoginScreen(),
    SignUpScreen.routeName: (ctx) => SignUpScreen(),
    DrawerNavigationScreen.routeName:(ctx) => const DrawerNavigationScreen()
  };
}
