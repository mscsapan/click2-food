class RemoteUrls {
  static const String rootUrl = "https://demo-api.devdata.top/";

  static const String baseUrl = '${rootUrl}api/';

  static const String register = '${baseUrl}store-register';

  static const String login = '${baseUrl}Administrator/Login';


  static String changePassword(String token) => '${baseUrl}user/update-password?token=$token';

  static String logout(String token) => '${baseUrl}user/logout?token=$token';
  static const String sendForgetPassword = '${baseUrl}send-forget-password';
  static const String resendRegisterCode = '${baseUrl}resend-register-code';

  static String storeResetPassword = '${baseUrl}store-reset-password';

  static String userVerification = '${baseUrl}user-verification';
  static String resendVerificationCode = '${baseUrl}resend-register';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
