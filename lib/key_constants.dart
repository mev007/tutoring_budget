// ignore_for_file: constant_identifier_names

class KeyConstants {
  static const String googleDisplayName = "displayName";
  static const String googleEmail = "email";
  static const String googleId = "id";
  static const String googlePhotoUrl = "photoUrl";
  static const String googleToken = "token";
  static const String facebookUserDataFields =
      "name,email,picture.width(200),birthday,friends,gender,link";
  static const String emailKey = 'email';
}

enum SignInType { EMAIL_PASSWORD, GOOGLE, FACEBOOK, PHONE }
