import 'package:flutter/material.dart';

/// to control all colors, app theme, without any need to dig into code
/// any new color or existing color will have a const with its value
/// there is a stand alone variable for any widget, text, image or icon
///
/// All name colors according to https://chir.ag/projects/name-that-color
///   100% - FF
///   95% - F2
///   90% - E6
///   85% - D9
///   80% - CC
///   75% - BF
///   70% - B3
///   65% - A6
///   60% - 99
///   55% - 8C
///    50% - 80
///    45% - 73
///    40% - 66
///    35% - 59
///   30% - 4D
///   25% - 40
///   20% - 33
///   15% - 26
///   10% - 1A
///    5% - 0D
///   0% - 00

class AppColors {
  static const _black = Colors.black;
  static const _white = Colors.white;

  static const _cloudBurst = Color(0xff183059);
  static const _wildSand = Color(0xffF5F5F5);

  static const _toryBlue = Color(0xff1151B4);

  static const _gray = Color(0xff667085);

  static const _blackCow = Color(0xff494947);
  static const _alto = Color(0xffD9D9D9);
  static const _nobel = Color(0xffB7B7B7);
  static const _oxfordBlue = Color(0xFF344053);
  static const _mischka = Color(0xFFCFD4DC);
  static const _paleSky = Color(0xFF667084);
  static const _codGray = Color(0xFF101010);
  static const _gallerySolid = Color(0xFFEFEFEF);


  /// app main theme ...
  static const colorSchemeSeed = _cloudBurst;
  static const colorPrimary = _toryBlue;
  static const focus = colorPrimary;
  static const scaffoldBackground = _wildSand;
  static const iconTheme = colorPrimary;
  static const placeholder = _nobel;

  static const bottomNavigationBackground = _white;
  static const bottomNavigationSelectedItem = colorPrimary;
  static const bottomNavigationUnselectedItem = _alto;

  static const appBarBackground = colorPrimary;
  static const appBarTextColor = _white;
  static const appBarIcon = _white;

  static const appMainButton = colorPrimary;
  static const appSecondButton = _white;
  static const appCancelButton = _codGray;

  static const floatActionBtnIcon = _white;
  static const floatActionBtnBackground = appSecondButton;

  static const titleMedium = colorPrimary;
  static const headlineMedium = _blackCow;
  static const bodyMedium = _cloudBurst;
  static const labelLarge = _paleSky;
  static const labelMedium = _alto;
  static const labelSmall = _alto;

  /// toast ..
  static const toastBackground = _black;
  static const toastText = _white;

  /// home widget ..

  static const searchItemColor = Color(0xff878787);


  /// app form field
  static const appFormFieldTitle = _oxfordBlue;
  static const appFormFieldFill = _white;
  static const enabledAppFormFieldBorder = _mischka;
  static const appFormFieldErrorIBorder = Colors.red;
  static const suffixIcon = _gray;
  static const formFieldText = _black;
  static const formFieldHintText = _paleSky;
  static const formFieldFocusIBorder = colorPrimary;
  static const pinCodeTextFieldFill = _white;
  static const pinCodeTextFieldActive = colorPrimary;
  static const pinCodeTextFieldInactive = colorPrimary;
  static const pinCodeTextFieldSelected = colorPrimary;
  static const countryPickerFormFieldBackground = _white;
  static const countryPickerFormFieldText = formFieldText;
  static const unCountryPickerFormFieldText = _paleSky;

  /// Custom DropDown Widget
  static const appDropdownFill = _white;
  static const appDropdownDisabledBorder = _paleSky;
  static const appDropdownEnabledBorder = _gray;
  static const appDropdownFocusedBorder = colorPrimary;

  /// dialogs ..
  static const closeDialogIcon = _nobel;

  /// paging
  static const paginationLoadingBackground = _white;

  /// app buttons
  static const appButtonText = _white;
  static const appButtonBlueBackground = colorPrimary;
  static const appButtonBlueText = colorPrimary;
  static const appButtonBorder = _mischka;
  static const appButtonWhiteBackground = _white;
  static const appTextButtonText = colorPrimary;
  static const appOutlinedButtonText = colorPrimary;
  static const appOutlinedButtonBorder = colorPrimary;
  static const appShareIcon = _alto;
  static const appCancelButtonBackground = _gallerySolid;

  /// login Screen
  static const loginWithAppleButtonBackground = _white;

}
