
import '../utils/build_type/build_type.dart';

class ApiKeys {
  /// KEYs
  static const clientId = "2";
  static const clientSecret = "xCRM0XXXXXXXXXXXXXXXXXXXXXXXXXpnhO";
  static const grantTypeLogin = "password";
  static const grantTypeRefreshToken = "refresh_token";
  static const authorization = "Authorization";
  static const guestToken = "guest_token";
  static const accept = "Accept";
  static const applicationJson = "application/json";
  static const locale = "Accept-Language";
  static const contentType = "Content-Type";
  static const keyBearer = "Bearer";

  /// URLs
  static const baseDevUrl = "https://devapi.xyz.com";
  static const baseProductionUrl = "https://api.xyz.com";

  static final currentEnvironment =
      isDevMode() ? baseDevUrl : baseProductionUrl;

  static const apiKeyUrl = "api";
  static const baseApiUrl = '/$apiKeyUrl';

  static const wATokenUrl = '$baseApiUrl/Users/WAToken';
  static const refreshTokenUrl = '$baseApiUrl/Users/refreshTokenUrl';
  static const refreshOtpUrl = '$baseApiUrl/Users/Refresh_Otp';
  static const checkOtpUrl = '$baseApiUrl/Users/Check_Otp';
  static const createAccountUrl = '$baseApiUrl/Users/Create_Account';
  static const finishAccountUrl = '$baseApiUrl/Users/Finish_Profile';
  static const loginUrl = '$baseApiUrl/Users/Login';
  static const socialSignUrl = '$baseApiUrl/Users/SocialSign';
  static const forgetPasswordUrl = '$baseApiUrl/Users/Forget_Password';
  static const resetPasswordUrl = '$baseApiUrl/Users/ResetPassword';
  static const uploadFileUrl = '$baseApiUrl/Files/uploadFileUrl';

}
