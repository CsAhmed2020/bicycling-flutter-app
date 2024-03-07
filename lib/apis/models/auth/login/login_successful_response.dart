class LoginSuccessfulResponse {
  final String message;
  final String accessToken;
  final String refreshToken;
  final String expiration;
  final String uuid;

  LoginSuccessfulResponse(
    this.message,
    this.accessToken,
    this.refreshToken,
    this.expiration,
    this.uuid,
  );
  static LoginSuccessfulResponse demo = LoginSuccessfulResponse(
      "message", "accessToken", "refreshToken", "expiration", "uuid");

  LoginSuccessfulResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String,
        accessToken = json['token'] as String,
        expiration = json['expiration'] as String,
        uuid = json['uuid'] as String,
        refreshToken = json['refreshToken'] as String;

  Map<String, dynamic> toJson() => {
        'token': accessToken,
        'message': message,
        'expiration': expiration,
        'refreshToken': refreshToken,
        'uuid': uuid,
      };
}
