import 'package:bicycling_app/utils/preferences/preferences_utils.dart';

import 'preferences_keys.dart';

class PreferencesManager {
  Future<bool> clearData() async {
    String? locale = await getLocale();
    await PreferencesUtils.clearData();
    if (locale != null) {
      await setLocale(locale);
    }
    return true;
  }

  Future<bool> setLocale(String data) async {
    return await PreferencesUtils.setString(PreferencesKeys.lang.name, data);
  }
  Future<String?> getLocale() async {
    return await PreferencesUtils.getString(PreferencesKeys.lang.name);
  }

  Future<void> setLoggedIn() async {
    await PreferencesUtils.setBool(PreferencesKeys.isLoggedIn.name, true);
  }

  Future<void> setAsGuest() async {
    await PreferencesUtils.setBool(PreferencesKeys.isGuest.name, true);
  }

  Future<void> setNotAsGuest() async {
    await PreferencesUtils.setBool(PreferencesKeys.isGuest.name, false);
  }

  Future<bool> isAsGuest() async {
    return await PreferencesUtils.getBool(PreferencesKeys.isGuest.name);
  }

  Future<void> setNotLoggedIn() async {
    await PreferencesUtils.setBool(PreferencesKeys.isLoggedIn.name, false);
  }

  Future<bool> isLoggedIn() async {
    return await PreferencesUtils.getBool(PreferencesKeys.isLoggedIn.name);
  }

  Future<void> setAccessToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.accessToken.name, data);
  }
  Future<String?> getAccessToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.accessToken.name);
  }

  Future<void> setRefreshToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.refreshToken.name, data);
  }
  Future<String?> getRefreshToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.refreshToken.name);
  }

  Future<void> setName(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.name.name, data);
  }
  Future<String?> getName() async {
    return await PreferencesUtils.getString(PreferencesKeys.name.name);
  }

  Future<void> setUserImageUrl(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.userImageUrl.name, data);
  }
  Future<String?> getUserImageUrl() async {
    return await PreferencesUtils.getString(PreferencesKeys.userImageUrl.name);
  }

  Future<void> setExpiresToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.expiresIn.name, data);
  }
  Future<String?> getExpiresToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.expiresIn.name);
  }

  Future<void> setUUID(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.uuid.name, data);
  }
  Future<String?> getUUID() async {
    return await PreferencesUtils.getString(PreferencesKeys.uuid.name);
  }

  Future<void> setEmail(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.email.name, data);
  }
  Future<String?> getEmail() async {
    return await PreferencesUtils.getString(PreferencesKeys.email.name);
  }

  Future<void> setAbout(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.about.name, data);
  }
  Future<String?> getAbout() async {
    return await PreferencesUtils.getString(PreferencesKeys.about.name);
  }

  Future<void> setMobileNumber(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.mobileNumber.name, data);
  }
  Future<String?> getMobileNumber() async {
    return await PreferencesUtils.getString(PreferencesKeys.mobileNumber.name);
  }



  Future<void> setTokenData(String accessToken, String refreshToken,
      String expiresIn, String uuid) async {
    await setAccessToken(accessToken);
    await setRefreshToken(refreshToken);
    await setExpiresToken(expiresIn);
    await setUUID(uuid);
  }

  Future<void> saveUserInfo({
    required String fullName,
    required String email,
    required String about,
    required String mobileNumber,
    required String? imageUrl,
    required bool phoneVerified,
    required bool mailVerified,
    required bool profileVerified,
  }) async {
    await setName(fullName);
    await setEmail(email);
    await setAbout(about);
    await setMobileNumber(mobileNumber);
    if (imageUrl != null) {
      await setUserImageUrl(imageUrl);
    }
  }

}
