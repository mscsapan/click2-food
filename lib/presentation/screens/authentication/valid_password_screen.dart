import '/presentation/widgets/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/auth/auth_state_model.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/error_text.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class ValidPasswordScreen extends StatefulWidget {
  const ValidPasswordScreen({super.key});

  @override
  State<ValidPasswordScreen> createState() => _ValidPasswordScreenState();
}

class _ValidPasswordScreenState extends State<ValidPasswordScreen> {
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
          BlocBuilder<AuthBloc, AuthStateModel>(
            builder: (context, auth) {
              final state = auth.authState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                      initialValue: auth.password,
                      onChanged: (String text) => authBloc
                        ..add(AuthEventPassword(text))
                        ..add(const AuthPasswordValidate()),
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
                          child:  IconButton(
                            onPressed: ()=>authBloc.add(const AuthShowPassword()),
                           icon:  Icon(
                            auth.isActive?  Icons.visibility_off_rounded:Icons.visibility_outlined,
                             color: grayColor3,
                             size: 22.0,
                           ),
                          ),
                        ),
                      ),
                      obscureText: auth.isActive,
                      style: inputStyle),
                  Utils.verticalSpace(6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state is AuthInvalidPassword) ...[
                        ErrorText(text: state.message),
                      ] else ...[
                        const SizedBox.shrink()
                      ],
                      GestureDetector(
                        onTap: () {
                          // context.read<ForgotPasswordCubit>().clear();
                          Navigator.pushNamed(
                              context, RouteNames.forgotPasswordScreen);
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
                    ],
                  ),
                ],
              );
            },
          ),
          Utils.verticalSpace(24.0),
          BlocConsumer<AuthBloc, AuthStateModel>(
            listener: (context, auth) {
              final state = auth.authState;

              if(state is AuthStateError){
                authBloc.add(const AuthEventReset());
                Utils.errorSnackBar(context, state.message);
              }else if(state is AuthStateLoaded){
                authBloc.add(const AuthEventReset());
                // Utils.showSnackBar(context, state.responses);
                Navigator.pushNamedAndRemoveUntil(context,RouteNames.homeScreen,(route)=>false);
              }
            },
            builder: (context, auth) {
              final state = auth.authState;
              if(state is AuthStateLoading){
                return const LoadingWidget();
              }
              return PrimaryButton(
                  text: 'Login',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    if(auth.password.trim().isNotEmpty && Utils.isValidPassword(auth.password)){
                      authBloc.add(const AuthEventLogin());
                    }
                    // Navigator.pushNamed(context, RouteNames.loginScreen)
                  },
                  buttonType: ButtonType.icon);
            },
          ),
          Utils.verticalSpace(20.0),
          const CustomText(
              text: 'Log in with phone number',
              fontWeight: FontWeight.w600,
              color: grayColor3,
              textAlign: TextAlign.center),
          Container(
            alignment: Alignment.bottomCenter,
            margin: Utils.only(top: Utils.mediaQuery(context).height * 0.16),
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
