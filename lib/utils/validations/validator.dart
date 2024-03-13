import 'package:bicycling_app/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';

class Validator {
  static bool isEmail(String email) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    var regExp = RegExp(pattern);

    return regExp.hasMatch(email.trim());
  }

  static bool containEmail(String text) {
    RegExp regExp = RegExp(
        r'([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)',
        multiLine: true);

    return regExp.hasMatch(text);
  }

  static bool containPhoneNumber(String text) {
    // For Arabic and english Number
    // RegExp regExp = RegExp(r'^[\u0660-\u0669\s0-9]{9}', multiLine: true);
    RegExp regExp = RegExp(r'(\d{9})', multiLine: true);

    return regExp.hasMatch(text);
  }

  static bool isNumber(String number) {
    const String pattern = r'^[0-9]+$';

    var regExp = RegExp(pattern);

    return regExp.hasMatch(number.trim());
  }

  static bool isUrl(String url) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';

    var regExp = RegExp(pattern);

    return regExp.hasMatch(url.trim());
  }

  static bool isName(String name) {
    const String pattern = r'^[a-zA-Z]+$';
    var regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }

  static bool isPassportNumber(String name) {
    const String pattern = r'^(?!^0+$)[a-zA-Z0-9]{3,20}$';
    var regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }

  static ValidationState validateEmail(String? email) {
    if (email.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (!isEmail(email!)) {
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validatePassword(String? password) {
    if (password.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (password!.length < 8) {
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateAuthCode(String code) {
    if (code.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (code.length != 6) {
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateNumber(String? number, {int length = 9}) {
    if (number.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (!isNumber(number!) || number.length != length) {
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validatePassportNumber(String? number) {
    if (number.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (!isPassportNumber(number!)) {
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateText(String? text) {
    if (text.isNullOrEmpty) {
      return ValidationState.empty;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return ValidationState.empty;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return ValidationState.empty;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateTextWithText(
      String? textNeedToValid, String correctText) {
    if (textNeedToValid.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (textNeedToValid! != correctText) {
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }

  static ValidationState validateEmailOrPhoneNumber(
      String? emailOrPhoneNumber) {
    if (emailOrPhoneNumber.isNullOrEmpty) {
      return ValidationState.empty;
    } else if (!isEmail(emailOrPhoneNumber!)) {
      if (isNumber(emailOrPhoneNumber) && emailOrPhoneNumber.length == 9) {
        return ValidationState.valid;
      }
      return ValidationState.formatting;
    } else {
      return ValidationState.valid;
    }
  }
}

enum ValidationState { empty, formatting, valid }
