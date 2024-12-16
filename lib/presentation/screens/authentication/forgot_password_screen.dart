import '../../widgets/custom_app_bar.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                path: KImages.forgotPasswordIcon,
                fit: BoxFit.cover,
              )),
          Utils.verticalSpace(16.0),
          const CustomText(
              text: 'Forgot password?',
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(8.0),
          const CustomText(
              text: "Don't worry, we'll help you reset it in no time. Provide your email or phone to get an OTP code.",
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter email address',
                prefixIcon: Padding(
                  padding: Utils.only(top: 2.0),
                  child: const Icon(
                    Icons.email_outlined,
                    color: grayColor3,
                    size: 24.0,
                  ),
                ),
              ),
              style: inputStyle),
          Utils.verticalSpace(24.0),
          PrimaryButton(
              text: 'Send OTP',
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.verificationScreen,arguments: false),
              buttonType: ButtonType.icon),
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
