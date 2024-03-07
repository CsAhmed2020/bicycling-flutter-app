import 'dart:async';

import 'package:bicycling_app/features/splash/bloc/splash_bloc.dart';
import 'package:bicycling_app/features/splash/bloc/splash_repository.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../_base/base_widgets/base_stateful_screen_widget.dart';
import '../../apis/_base/dio_api_manager.dart';
import '../../res/app_asset_paths.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  SplashScreen({Key? key}) : super(key: key);

  final DioApiManager dioApiManager = GetIt.I<DioApiManager>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(SplashRepository(
        preferencesManager: GetIt.I<PreferencesManager>(),
      )),
      child: const SplashScreenWithBloc(),
    );
  }
}

class SplashScreenWithBloc extends BaseStatefulScreenWidget {
  const SplashScreenWithBloc({Key? key}) : super(key: key);

  @override
  BaseScreenState<SplashScreenWithBloc> baseScreenCreateState() =>
      _SplashScreenWithBlocState();
}

class _SplashScreenWithBlocState extends BaseScreenState<SplashScreenWithBloc> {
  var preferencesManager = GetIt.I<PreferencesManager>();

  @override
  void initState() {
    super.initState();
    _getAreaList();

    /// to start time to switch to another screen
    _startTime();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        // if (state is AreaLoadedState) {
        //   _navigationPage();
        // }
      },
      child: Scaffold(
        body: _backgroundImage(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _backgroundImage() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(AppAssetPaths.splashBackground, fit: BoxFit.fill),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  /// time to switch with dummy screen
  Future<Timer> _startTime() async {
    var duration = const Duration(milliseconds: 1500);
    return Timer(duration, _navigationPage);
  }

  SplashBloc get currentBloc => BlocProvider.of<SplashBloc>(context);

  void _getAreaList() {
    currentBloc.add(GetAreaListApi());
  }

  /// navigate to next screen
  Future<void> _navigationPage() async {
    try {
      bool isLogged = await preferencesManager.isLoggedIn();
      if (isLogged) {
        _openHomeScreen();
      } else {
        _openLoginScreen();
      }
    } catch (error) {
      _openLoginScreen();
    }
  }

  void _openLoginScreen() async {
    //await Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  void _openHomeScreen() async {
    //await Navigator.of(context).pushNamedAndRemoveUntil(BottomNavigationScreen.routeName, ((route) => false));
  }
}
