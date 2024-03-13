import 'package:bicycling_app/apis/_base/dio_api_manager.dart';
import 'package:bicycling_app/features/welcome_screens/splash/splash_screen.dart';
import 'package:bicycling_app/utils/bloc_observer/app_bloc_observer.dart';
import 'package:bicycling_app/utils/build_type/build_type.dart';
import 'package:bicycling_app/utils/locale/app_localization.dart';
import 'package:bicycling_app/utils/locale/app_localization_keys.dart';
import 'package:bicycling_app/utils/locale/locale_cubit.dart';
import 'package:bicycling_app/utils/locale/locale_repository.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';
import 'package:bicycling_app/utils/theme/app_theme.dart';
import 'package:bicycling_app/utils/theme/theme_cubit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'app_route.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred device orientation to portrait up.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

// Register singletons for the PreferencesManager and DioApiManager using GetIt.
  GetIt.I.registerLazySingleton<PreferencesManager>(() => PreferencesManager());
  GetIt.I.registerLazySingleton<DioApiManager>(() =>
      DioApiManager(GetIt.I<PreferencesManager>(), _failedToRefreshToken));

  // Set the AppBlocObserver as the observer for all BLoCs.
  Bloc.observer = AppBlocObserver();

  // Run the application using the MyApp widget.
  runApp(isDevMode()
      ? const RequestsInspector(
    enabled: true,
    showInspectorOn: ShowInspectorOn.Both,
    child: MyApp(),
  )
      : const MyApp());
}

void _failedToRefreshToken() {
  // Clear user data
  GetIt.I<PreferencesManager>().clearData();

  // Navigate to the login screen
  /*AppRoute.mainNavigatorKey.currentState?.pushNamedAndRemoveUntil(
    LoginScreen.routeName,
        (_) => false,
  );*/
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (context) => LocaleCubit(LocaleRepository(
              preferenceManager: GetIt.I<PreferencesManager>())),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, BaseAppTheme>(
        builder: (context, appThemeState) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, state) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: appThemeState.themeDataLight.primaryColor,
                ),
                child: ScreenUtilInit(
                      designSize: const Size(375, 812),
                      builder: (context, child) => MaterialApp(
                        onGenerateTitle: (BuildContext context) =>
                        AppLocalizations.of(context)
                            ?.translate(LocalizationKeys.appName) ??
                            "Scooter",
                        debugShowCheckedModeBanner: isDevMode(),
                        theme: appThemeState.themeDataLight,
                        darkTheme: appThemeState.themeDataDark,
                        themeMode: ThemeMode.light,

                        /// the list of our supported locals for our app
                        /// currently we support only 2 English and Arabic ...
                        supportedLocales: AppLocalizations.supportedLocales,

                        /// these delegates make sure that the localization data
                        /// for the proper
                        /// language is loaded ...
                        localizationsDelegates: const [
                          /// A class which loads the translations from JSON files
                          AppLocalizations.delegate,

                          /// Built-in localization of basic text
                          ///  for Material widgets in Material
                          GlobalMaterialLocalizations.delegate,

                          /// Built-in localization for text direction LTR/RTL
                          GlobalWidgetsLocalizations.delegate,

                          /// Built-in localization for text direction LTR/RTL in Cupertino
                          GlobalCupertinoLocalizations.delegate,

                          DefaultCupertinoLocalizations.delegate,

                          /// A specific localization delegate for Country Picker
                          CountryLocalizations.delegate,
                        ],
                        locale: state,
                        navigatorKey: AppRoute.mainNavigatorKey,
                        routes: AppRoute.routes,
                        home: SplashScreen(),
                      ),
                    ),

              );
            },
          );
        },
      ),
    );
  }

}
