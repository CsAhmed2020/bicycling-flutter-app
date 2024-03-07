import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_localization.dart';
import 'locale_repository.dart';

class LocaleCubit extends Cubit<Locale> {
  final BaseLocaleRepository localeRepository;

  LocaleCubit(this.localeRepository) : super(const Locale(codeEn)) {
    getDefaultLocale();
  }

  void changeLocale(LocaleApp selectedLanguage) async {
    final defaultLanguageCode = await localeRepository.getLanguageLocal();
    if (selectedLanguage == LocaleApp.ar && defaultLanguageCode != codeAr) {
      await localeRepository.updateLanguageInfo(LocaleApp.ar);
      emit(const Locale(codeAr));
    } else if (selectedLanguage == LocaleApp.en &&
        defaultLanguageCode != codeEn) {
      await localeRepository.updateLanguageInfo(LocaleApp.en);
      emit(const Locale(codeEn));
    }
  }

  void getDefaultLocale() async {
    final defaultLanguageCode = await localeRepository.getLanguageLocal();
    Locale locale;
    if (defaultLanguageCode == null) {
      locale = Locale(defaultSystemLocale);
      localeRepository.changeLanguageLocal(LocaleApp.en);
    } else {
      locale = Locale(defaultLanguageCode);
      localeRepository
          .changeLanguageLocal(LocaleApp.fromLanguageCode(defaultLanguageCode));
    }
    emit(locale);
  }

  String get defaultSystemLocale => Platform.localeName.substring(0, 2);
}

enum LocaleApp {
  en,
  ar;

  String mapToApiKey() {
    switch (this) {
      case LocaleApp.en:
        return "en-US";
      case LocaleApp.ar:
        return "ar-AR";
    }
  }

  String mapToPreferenceKey() {
    switch (this) {
      case LocaleApp.en:
        return codeEn;
      case LocaleApp.ar:
        return codeAr;
    }
  }

  static LocaleApp fromLanguageCode(String languageCode) {
    switch (languageCode) {
      case codeEn:
        return LocaleApp.en;
      case codeAr:
        return LocaleApp.ar;
      default:
        return LocaleApp.en;
    }
  }
}
