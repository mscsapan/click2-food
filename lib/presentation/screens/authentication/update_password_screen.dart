import '/presentation/widgets/custom_form.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

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
                path: KImages.updatePassIcon,
                fit: BoxFit.cover,
              )),
          Utils.verticalSpace(16.0),
          const CustomText(
              text: 'Setup new password',
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(8.0),
          const CustomText(
              text: 'Enter a secure key (at least 6 characters',
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          CustomForm(label: 'Enter new password', bottomSpace: 16.0,
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
          CustomForm(label: 'Confirm new password', bottomSpace: 16.0,
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
          text: 'Save and continue',
          onPressed: () => Navigator.pushNamed(
              context, RouteNames.updatePasswordScreen,
              arguments: false),
          buttonType: ButtonType.icon),
    );
  }
}
