import '../../widgets/custom_app_bar.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class ValidPasswordScreen extends StatelessWidget {
  const ValidPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: Utils.symmetric(),
        shrinkWrap: true,
        children: [
          const Align(
              alignment: Alignment.topLeft,
              child: CustomImage(
                path: KImages.passwordIcon,
                fit: BoxFit.cover,
              )),
          Utils.verticalSpace(16.0),
          const CustomText(
              text: 'Enter your password',
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(8.0),
          const CustomText(
              text: 'Please enter your password to continue.',
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          TextFormField(
              decoration: InputDecoration(
                hintText: 'Type your password',
                prefixIcon: Padding(
                  padding: Utils.only(top: 2.0),
                  // child: CustomImage(path: KImages.lockIcon,height: 20.0,width: 20.0,fit: BoxFit.contain,),
                  child: const Icon(
                    Icons.lock_outline,
                    color: grayColor3,
                    size: 24.0,
                  ),
                ),
                suffixIcon: Padding(
                  padding: Utils.only(top: 2.0),
                  child: const Icon(
                    Icons.visibility_outlined,
                    color: grayColor3,
                    size: 22.0,
                  ),
                ),
              ),
              obscureText: true,
              style: inputStyle),
          Utils.verticalSpace(8.0),
          GestureDetector(
            onTap: () {
              // context.read<ForgotPasswordCubit>().clear();
              Navigator.pushNamed(context, RouteNames.forgotPasswordScreen);
            },
            child: const CustomText(
              text: 'Forgot password?',
              fontSize: 14.0,
              textAlign: TextAlign.end,
              fontWeight: FontWeight.w600,
              color: Color(0xFF757D85),
              height: 1.6,
            ),
          ),
          Utils.verticalSpace(24.0),
          PrimaryButton(
              text: 'Login',
              onPressed: () {
                // Navigator.pushNamed(context, RouteNames.loginScreen)
              },
              buttonType: ButtonType.icon),
          Utils.verticalSpace(20.0),
          const CustomText(
              text: 'Log in with phone number',
              fontWeight: FontWeight.w600,
              color: grayColor3,
              textAlign: TextAlign.center),
          Container(
            alignment: Alignment.bottomCenter,
            margin: Utils.only(top: Utils.mediaQuery(context).height * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(
                    text: 'Sign in with',
                    fontWeight: FontWeight.w600,
                    color: grayColor3,
                    textAlign: TextAlign.center),
                Utils.verticalSpace(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon(KImages.google),
                    Utils.horizontalSpace(16.0),
                    _socialIcon(KImages.apple),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String icon) {
    return CircleAvatar(
      maxRadius: 22.0,
      backgroundColor: const Color(0xFFF0F0F0),
      child: CustomImage(path: icon),
    );
  }
}
