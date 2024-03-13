import 'package:bicycling_app/apis/_base/dio_api_manager.dart';
import 'package:bicycling_app/apis/api_managers/auth_api_manager.dart';
import 'package:bicycling_app/apis/models/auth/login/login_successful_response.dart';
import 'package:bicycling_app/features/auth/_base/base_auth_screen.dart';
import 'package:bicycling_app/features/auth/helper/auth_validate.dart';
import 'package:bicycling_app/features/auth/login/screen/login_screen.dart';
import 'package:bicycling_app/features/auth/otp/screen/otp_screen.dart';
import 'package:bicycling_app/features/auth/signup/bloc/sign_up_bloc.dart';
import 'package:bicycling_app/features/auth/signup/bloc/sign_up_repository.dart';
import 'package:bicycling_app/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:bicycling_app/features/widgets/app_buttons/app_text_button.dart';
import 'package:bicycling_app/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:bicycling_app/features/widgets/text_field/phone_number_form_filed_widget.dart';
import 'package:bicycling_app/res/app_colors.dart';
import 'package:bicycling_app/utils/feedback/feedback_message.dart';
import 'package:bicycling_app/utils/locale/app_localization_keys.dart';
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:phone_form_field/phone_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-up-screen';

  static Future<void> open(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  final DioApiManager dioApiManager = GetIt.I<DioApiManager>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(SignUpRepository(
        authApiManager: AuthApiManager(dioApiManager),
        preferencesManager: GetIt.I<PreferencesManager>(),
      )),
      child: const SignUpScreenWithBloc(),
    );
  }
}

class SignUpScreenWithBloc extends BaseAuthScreen {
  const SignUpScreenWithBloc({super.key});

  @override
  BaseAuthState<SignUpScreenWithBloc> baseScreenCreateState() {
    return _SignUpScreenWithBloc();
  }
}

class _SignUpScreenWithBloc extends BaseAuthState<SignUpScreenWithBloc>
    with AuthValidate{
  late PhoneNumber _phoneNumber;
  late String _fullName;
  late String _password;
  String _uuid = "";
  final bool _completedProfile = true;

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget bodyWidget(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (ctx, state) async {
        if (state is SignUpLoadingState) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state is SignUpErrorState) {
          showFeedbackMessage(state.isLocalizationKey
              ? translate(state.errorMassage)!
              : state.errorMassage);
        } else if (state is FormNotValidatedState) {
          autovalidateMode = AutovalidateMode.always;
        } else if (state is FormValidatedState) {
          _signUpEventApi();
        } else if (state is SignUpSuccessfullyState) {
          _uuid = "state.authSuccessfulResponse.uuid";
          _openOtpScreen("123");
        } else if (state is SignUpSocialSuccessfullyState) {
         // _saveTokenDataEvent(state.loginSuccessfulResponse);
        } else if (state is SaveTokenDataSuccessfullyState) {
          //_getUserInfoApiEvent();
        } else if (state is OpenHomeScreenState) {
          _openHomeScreen();
        } else if (state is OpenSignInScreenState) {
          _openLoginScreen();
        }
      },
      builder: (ctx, state) {
        return buildSignUpWidget();
      },
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget buildSignUpWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 10.h),
            _labelsWidgets(),
            SizedBox(height: 20.h),
            _loginFormWidget(),
            SizedBox(height: 20.h),
            _loginButtonsWidgets(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _labelsWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(translate(LocalizationKeys.signUp)!,
            style: textTheme.labelLarge?.copyWith(
              fontSize: 24.spMin,
              color: AppColors.colorPrimary,
            )),
      ],
    );
  }

  Widget _loginFormWidget() {
    return Form(
      key: signUpFormKey,
      autovalidateMode: autovalidateMode,
      child: AutofillGroup(
        child: Column(
          children: [
            AppTextFormField(
              title: translate(LocalizationKeys.fullName)!,
              hintText: translate(LocalizationKeys.enterYourName),
              onSaved: _fullNameSaved,
              textInputAction: TextInputAction.next,
              validator: textValidator,
              autofillHints: const [AutofillHints.name],
            ),
            const SizedBox(height: 20),
            PhoneNumberFormFiledWidget(
              title: translate(LocalizationKeys.whatsAppNumber)!,
              hintText: translate(LocalizationKeys.enterYourWhatsApp),
              autovalidateMode: autovalidateMode,
              onSaved: _phoneNumberSaved,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              helperText: translate(LocalizationKeys.mustBeAtLeast8Characters),
              title: translate(LocalizationKeys.password)!,
              hintText: translate(LocalizationKeys.createPassword),
              controller: _passwordController,
              onSaved: _passwordSaved,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: passwordValidator,
              obscure: true,
              autofillHints: const [
                AutofillHints.newPassword,
              ],
            ),
            SizedBox(height: 10.h),
            AppTextFormField(
              helperText: translate(LocalizationKeys.mustBeAtLeast8Characters),
              title: translate(LocalizationKeys.confirmPassword)!,
              hintText: translate(LocalizationKeys.confirmPassword),
              onSaved: _passwordSaved,
              obscure: true,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: (v) =>
                  confirmPasswordValidator(v, _passwordController.text),
              onFieldSubmitted: (_) => _continueClicked(),
              autofillHints: const [
                AutofillHints.newPassword,
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
          onPressed: _continueClicked,
          title: translate(LocalizationKeys.continuee)!,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translate(LocalizationKeys.alreadyHaveAnAccount)!,
                style: textTheme.labelLarge),
            const SizedBox(width: 5),
            AppTextButton.withTitle(
                onPressed: _loginClicked,
                padding: EdgeInsets.zero,
                title: translate(LocalizationKeys.logIn)!),
          ],
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  void _phoneNumberSaved(PhoneNumber? value) {
    _phoneNumber = value!;
  }

  void _passwordSaved(String? value) {
    _password = value!;
  }

  void _fullNameSaved(String? value) {
    _fullName = value!;
  }

  SignUpBloc get currentBloc => BlocProvider.of<SignUpBloc>(context);

  void _continueClicked() {
    currentBloc.add(ValidateFormEvent(signUpFormKey));
  }

  void _signUpEventApi() {
    currentBloc.add(SignUpApiEvent(
        _phoneNumber.international.substring(1), _password, _fullName));
  }

  void _loginClicked() {
    currentBloc.add(LoginClickedEventEvent());
  }

  void _saveTokenDataEvent(LoginSuccessfulResponse loginSuccessfulResponse) {
    currentBloc.add(SaveTokenDataEvent("loginSuccessfulResponse"));
  }



  Future<void> _openHomeScreen() async {
   // await Navigator.of(context).pushNamedAndRemoveUntil(BottomNavigationScreen.routeName, ((route) => false));
  }

  Future<void> _completedProfileScreen(String uuid, bool useMobile) async {
    //CompletedProfileScreen.open(context, uuid, useMobile: useMobile);
  }

  Future<void> _openLoginScreen() async {
    LoginScreen.open(context);
  }

  Future<void> _openOtpScreen(String uuid) async {
    OtpScreen.open(context, uuid, openAfterCheckOtp: OpenAfterCheckOtp.completeInfoScreen);
  }
}
