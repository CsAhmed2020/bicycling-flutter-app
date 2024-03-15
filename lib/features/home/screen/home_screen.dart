import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../_base/base_widgets/base_stateful_screen_widget.dart';
import '../../../apis/_base/dio_api_manager.dart';
import '../../../utils/feedback/feedback_message.dart';
import '../../../utils/preferences/preferences_manager.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_repository.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  static Future<void> open(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeScreen()), (_) => false);
  }

  final DioApiManager dioApiManager = GetIt.I<DioApiManager>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(HomeRepository(
        preferencesManager: GetIt.I<PreferencesManager>(),
      )),
      child: const HomeScreenWithBloc(),
    );
  }
}

class HomeScreenWithBloc extends BaseStatefulScreenWidget {
  const HomeScreenWithBloc({super.key});

  @override
  BaseScreenState<HomeScreenWithBloc> baseScreenCreateState() {
    return _HomeScreenWithBloc();
  }
}

class _HomeScreenWithBloc extends BaseScreenState<HomeScreenWithBloc> {

  @override
  void initState() {
    //Future.microtask(_getBestOfferInfoApiEvent);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        //_checkNotification();
      });
    });
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }

            if (state is HomeErrorState) {
              showFeedbackMessage(state.isLocalizationKey
                  ? translate(state.errorMassage)!
                  : state.errorMassage);
            }
          },
          child: Column(
            children: [
              SizedBox(height: 10.h),
              const Text("Home")
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////



  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  HomeBloc get currentBloc => BlocProvider.of<HomeBloc>(context);

  void _getXEventApi() {
    currentBloc.add(const GetXApiEvent());
  }
}
