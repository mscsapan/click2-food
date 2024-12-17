import 'package:click_food/data/models/auth/auth_state_model.dart';
import 'package:click_food/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../widgets/error_text.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

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
                path: KImages.loginIcon,
                fit: BoxFit.cover,
              )),
          Utils.verticalSpace(16.0),
          const CustomText(
              text: 'Log in with email',
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(8.0),
          const CustomText(
              text: 'Let’s log in into your Click To Food account',
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          BlocBuilder<AuthBloc, AuthStateModel>(
            builder: (context, auth) {
              final state = auth.authState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: auth.email,
                      onChanged: (String text)=> authBloc..add(AuthEventUserEmail(text))..add(const AuthEmailValidate()),
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
                  if (state is AuthInvalidEmail) ...[
                    ErrorText(text: state.message),
                  ]
                ],
              );
            },
          ),
          Utils.verticalSpace(24.0),
          PrimaryButton(
              text: 'Continue',
              onPressed: () {
                Utils.closeKeyBoard(context);
                if(authBloc.state.email.trim().isNotEmpty && Utils.isValidEmail(authBloc.state.email)){
                  // debugPrint('valid');
                  Navigator.pushNamed(context, RouteNames.validPasswordScreen);
                }
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
