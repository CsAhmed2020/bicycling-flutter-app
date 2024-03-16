import 'package:bicycling_app/apis/_base/dio_api_manager.dart';
import 'package:bicycling_app/apis/api_managers/auth_api_manager.dart';
import 'package:bicycling_app/apis/models/auth/login/login_successful_response.dart';
import 'package:bicycling_app/features/auth/_base/base_auth_screen.dart';
import 'package:bicycling_app/features/auth/forget_password/screen/forget_password_screen.dart';
import 'package:bicycling_app/features/auth/helper/auth_validate.dart';
import 'package:bicycling_app/features/auth/login/bloc/login_bloc.dart';
import 'package:bicycling_app/features/auth/login/bloc/login_repository.dart';
import 'package:bicycling_app/features/auth/otp/screen/otp_screen.dart';
import 'package:bicycling_app/features/auth/signup/screen/sign_up_screen.dart';
import 'package:bicycling_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:bicycling_app/features/widgets/app_buttons/app_text_button.dart';
import 'package:bicycling_app/features/widgets/logo/app_logo_title_widget.dart';
import 'package:bicycling_app/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:bicycling_app/features/widgets/text_field/phone_number_form_filed_widget.dart';
import 'package:bicycling_app/only_debug/user_debug_model.dart';
import 'package:bicycling_app/res/app_colors.dart';
import 'package:bicycling_app/utils/build_type/build_type.dart';
import 'package:bicycling_app/utils/feedback/feedback_message.dart';
import 'package:bicycling_app/utils/locale/app_localization_keys.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:phone_form_field/phone_form_field.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';

  static Future<void> open(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (_) => false);
  }

  final DioApiManager dioApiManager = GetIt.I<DioApiManager>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginRepository(
        authApiManager: AuthApiManager(dioApiManager),
        preferencesManager: GetIt.I<PreferencesManager>(),
      )),
      child: const LoginScreenWithBloc(),
    );
  }
}

class LoginScreenWithBloc extends BaseAuthScreen {
  const LoginScreenWithBloc({super.key});

  @override
  BaseAuthState<LoginScreenWithBloc> baseScreenCreateState() {
    return _LoginScreenWithBloc();
  }
}

class _LoginScreenWithBloc extends BaseAuthState<LoginScreenWithBloc>
    with AuthValidate {
  late PhoneNumber _phoneNumber;
  late String _password;
  PhoneNumber? _initialPhoneNumber;
  String? _initialPassword;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    if (isDebugMode()) _setDebugEmailPasswordAutomatic();
  }

  @override
  Widget bodyWidget(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (ctx, state) async {
        if (state is LoginLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is LoginErrorState) {
          showFeedbackMessage(state.isLocalizationKey
              ? translate(state.errorMassage)!
              : state.errorMassage);
        } else if (state is PhoneAndPasswordNotValidatedState) {
          autovalidateMode = AutovalidateMode.always;
        } else if (state is PhoneAndPasswordValidatedState) {
          _loginEventApi();
        } else if (state is LoginSuccessfullyState) {
          //_saveTokenDataEvent(state.loginSuccessfulResponse);
          _openOtpScreen("123");
        } else if (state is LoginFailState) {
          showFeedbackMessage(state.loginFailResponse);
        } else if (state is SaveTokenDataSuccessfullyState) {
        } else if (state is OpenHomeScreenState) {
          _openHomeScreen();
        } else if (state is OpenForgetPasswordScreenState) {
          _openRecoveryPasswordScreen();
        } else if (state is OpenSignUpScreenState) {
          _openRegisterScreen();
        }
      },
      builder: (ctx, state) {
        return buildLoginWidget();
      },
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget buildLoginWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 20.h),
            const Center(child: AppLogoTitleWidget()),
            SizedBox(height: 25.h),
            _labelsWidgets(),
            SizedBox(height: 30.h),
            _loginFormWidget(),
            _loginButtonsWidgets(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _labelsWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(translate(LocalizationKeys.logInToYourAccount)!,
            style: textTheme.labelLarge?.copyWith(
              fontSize: 24.spMin,
              color: AppColors.colorPrimary,
            )),
        SizedBox(height: 10.h),
        Text(translate(LocalizationKeys.welcomeBackPleaseEnterYourDetails)!,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.appCancelButton,
              fontSize: 16.spMin,
            )),
      ],
    );
  }

  Widget _loginFormWidget() {
    return Form(
      key: loginFormKey,
      autovalidateMode: autovalidateMode,
      child: AutofillGroup(
        child: Column(
          children: [
            PhoneNumberFormFiledWidget(
              title: translate(LocalizationKeys.whatsAppNumber)!,
              hintText: "ex.1234567890",
              autovalidateMode: autovalidateMode,
              onSaved: _phoneNumberSaved,
              initialValue: _initialPhoneNumber,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              title: translate(LocalizationKeys.password)!,
              hintText: translate(LocalizationKeys.enterPassword),
              onSaved: _passwordSaved,
              obscure: true,
              textInputAction: TextInputAction.done,
              initialValue: _initialPassword,
              validator: passwordValidator,
              onFieldSubmitted: (_) => _loginClicked(),
              autofillHints: const [AutofillHints.password],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTextButton.withTitle(
                    onPressed: _forgotPasswordClicked,
                    padding: EdgeInsets.zero,
                    title: translate(LocalizationKeys.forgotPassword)!),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _loginButtonsWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppElevatedButton.withTitle(
          onPressed: _loginClicked,
          title: translate(LocalizationKeys.signIn)!,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translate(LocalizationKeys.dontHaveAnAccount)!,
                style: textTheme.labelLarge),
            const SizedBox(width: 5),
            AppTextButton.withTitle(
                onPressed: _createNewAccountClicked,
                padding: EdgeInsets.zero,
                title: translate(LocalizationKeys.signUp)!),
          ],
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////


  void _setDebugEmailPasswordAutomatic() {
    _initialPhoneNumber = UserDebugModel.phoneNumber;
    _initialPassword = UserDebugModel.usersPassword;
  }

  void _phoneNumberSaved(PhoneNumber? value) {
    _phoneNumber = value!;
  }

  void _passwordSaved(String? value) {
    _password = value!;
  }

  LoginBloc get currentBloc => BlocProvider.of<LoginBloc>(context);

  void _loginClicked() {
    currentBloc.add(ValidatePhonePasswordEvent(loginFormKey));
  }

  void _loginEventApi() {
    currentBloc.add(LoginWithPhonePasswordEvent(
        _phoneNumber.international.substring(1), _password));
  }

  void _createNewAccountClicked() {
    currentBloc.add(SignUpClickedEventEvent());
  }

  void _forgotPasswordClicked() {
    currentBloc.add(ForgotPasswordClickedEvent());
  }

  void _saveTokenDataEvent(LoginSuccessfulResponse loginSuccessfulResponse) {
    currentBloc.add(SaveTokenDataEvent("loginSuccessfulResponse"));
  }

  void _setAsLoggedUserEvent() {
    currentBloc.add(SetAsLoggedUserEvent());
  }



  Future<void> _openHomeScreen() async {
    /*await Navigator.of(context).pushNamedAndRemoveUntil(
        BottomNavigationScreen.routeName, ((route) => false));*/
  }

  Future<void> _completedProfileScreen(String uuid, bool useMobile) async {
    //CompletedProfileScreen.open(context, uuid, useMobile: useMobile);
  }

  Future<void> _openOtpScreen(String uuid) async {
    OtpScreen.open(context, uuid, openAfterCheckOtp: OpenAfterCheckOtp.homeScreen);
  }

  Future<void> _openRegisterScreen() async {
    SignUpScreen.open(context);
  }

  Future<void> _openRecoveryPasswordScreen() async {
    ForgetPasswordScreen.open(context);
  }
}
