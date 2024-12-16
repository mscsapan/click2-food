import 'package:flutter/material.dart';


import '../screens/authentication/sign_up_screen.dart';
import '../screens/authentication/valid_password_screen.dart';
import 'route_packages_name.dart';

class RouteNames {
  ///authentication routes
  static const String splashScreen = '/splashScreen';
  static const String authOptionScreen = '/authOptionScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String validPasswordScreen = '/validPasswordScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String updatePasswordScreen = '/updatePasswordScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String homeScreen = '/homeScreen';

  ///setting routes
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String faqScreen = '/faqScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String aboutUsScreen = '/aboutUsScreen';

  ///profile routes
  static const String profileScreen = '/profileScreen';
  static const String updateProfileScreen = '/updateProfileScreen';
  static const String providerProfileScreen = '/updateShopScreen';
  static const String reviewScreen = '/reviewScreen';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

        case RouteNames.authOptionScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthOptionScreen());

      case RouteNames.loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());

        case RouteNames.signUpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignUpScreen());

        case RouteNames.validPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ValidPasswordScreen());

      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotPasswordScreen());
      case RouteNames.updatePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UpdatePasswordScreen());
      case RouteNames.verificationScreen:
        final isNew = settings.arguments as bool;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => OtpVerificationScreen(isNew: isNew));

      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: FetchErrorText(
                text: 'No Route Found ${settings.name}', textColor: blackColor),
          ),
        );
    }
  }
}
