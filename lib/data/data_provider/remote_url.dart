class RemoteUrls {
  static const String rootUrl = "https://demo-api.devdata.top/";

  static const String baseUrl = '${rootUrl}api/';

  static const String register = '${baseUrl}store-register';

  static const String login = '${baseUrl}Administrator/Login';

  static const String addUser = '${baseUrl}Administrator/SaveUser';

  static const String checkUser = '${baseUrl}Administrator/CheckUserExists';

  static const String sendOtp = '${baseUrl}Administrator/SendOTPToEmail';

  static const String verifyOtp = '${baseUrl}Administrator/CheckOTPFromEmail';


  static String changePassword(String token) => '${baseUrl}user/update-password?token=$token';

  static String logout(String token) => '${baseUrl}user/logout?token=$token';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;
}
