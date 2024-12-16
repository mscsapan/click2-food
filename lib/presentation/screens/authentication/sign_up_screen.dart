import 'package:flutter/material.dart';

import '/presentation/routes/route_packages_name.dart';
import '/presentation/widgets/custom_form.dart';
import '/presentation/widgets/primary_button.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: Utils.symmetric(),
        shrinkWrap: true,
        children: [
          const CustomText(
              text: 'Personal information',
              fontSize: 24.0,
              color: Color(0xFF2D3034),
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(6.0),
          const CustomText(
              text: 'Please provide us your information to continue',
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          CustomForm(
            label: '', bottomSpace: 0.0,topSpace: 0.0,
            child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Type your full name',
                  prefixIcon: Padding(
                    padding: Utils.only(top: 2.0),
                    child: const Icon(
                      Icons.person,
                      color: grayColor3,
                      size: 24.0,
                    ),
                  ),
                ),
                style: inputStyle),
          ),
          CustomForm(
            label: '', bottomSpace: 0.0,topSpace: 0.0,
            child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
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
          ),
          CustomForm(label: '', bottomSpace: 0.0,topSpace: 0.0,
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Type your password',
                    prefixIcon: Padding(
                      padding: Utils.only(top: 2.0),
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
                  style: inputStyle)),
          CustomForm(label: '', bottomSpace: 0.0,topSpace: 0.0,
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    prefixIcon: Padding(
                      padding: Utils.only(top: 2.0),
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
                  style: inputStyle)),
        ],
      ),
      bottomNavigationBar : _submitButton(context),
    );
  }

  Widget _submitButton(BuildContext context) {
    // final sCubit = context.read<AddAdditionalCubit>();
    return Container(
      padding: Utils.only(
        left: 20.0,
        right: 20.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      margin: Utils.symmetric(h: 0.0, v: 20.0).copyWith(bottom: 24.0),
      child:  PrimaryButton(
          text: 'Continue',
          onPressed: () {
            // Navigator.pushNamed(context, RouteNames.updatePasswordScreen,
            //     arguments: false)
          },
          buttonType: ButtonType.icon),
    );
  }
}
