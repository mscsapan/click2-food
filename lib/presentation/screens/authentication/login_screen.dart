import '../../../logic/bloc/otp/otp_bloc.dart';
import '/data/models/auth/auth_state_model.dart';
import '/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../widgets/error_text.dart';
import '../../widgets/loading_widget.dart';
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
                      onChanged: (String text) => authBloc
                        ..add(AuthEventUserEmail(text))
                        ..add(const AuthEmailValidate()),
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
         BlocConsumer<AuthBloc, AuthStateModel>(
           listener: (context,auth){
             final state = auth.authState;
             if(state is AuthStateExistUser){
               authBloc.add(const AuthEventReset());
               if(state.responses == false){
                 context.read<OtpBloc>().add(OtpEventEmail(auth.email));
                 _accountNotFound(context);
               }else{
                 Navigator.pushNamed(context, RouteNames.validPasswordScreen);
               }
               debugPrint('success ${state.responses}');
              }
           },
            builder: (context, auth) {
              final state = auth.authState;
              if(state is AuthStateLoading){
                return const LoadingWidget();
              }
              return PrimaryButton(
                  text: 'Continue',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    if (authBloc.state.email.trim().isNotEmpty && Utils.isValidEmail(authBloc.state.email)) {
                      authBloc.add(const AuthEventCheckUser());
                      // Navigator.pushNamed(context, RouteNames.validPasswordScreen);
                    }
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

  _accountNotFound(BuildContext context){
    // debugPrint('isListen ${authBloc.isListen}');
    Utils.showCustomDialog(context,
      radius: 16.0,
      padding: Utils.symmetric(h: 16.0),
      child: BlocListener<OtpBloc, AuthStateModel>(
        listener: (context, auth) {
          final state = auth.otpState;
            if(state is OtpStateOtpSending){
              Utils.loadingDialog(context);
            }else{
              // authBloc.add(const AuthEventReset());
              Utils.closeDialog(context);
              if(state is OtpStateError){
                // authBloc.add(const AuthEventReset());
                Utils.errorSnackBar(context, state.message);
              }else if(state is OtpStateOTPSent){
                // authBloc.add(const AuthEventReset());
                Utils.showSnackBar(context, state.responses);
                Navigator.pushNamed(context,RouteNames.verificationScreen,arguments: true);
              }
            }


        /*  if(state is AuthStateError){
            // authBloc.add(const AuthEventReset());
            Utils.errorSnackBar(context, state.message);
          }else if(state is AuthStateOTPSent){
            // authBloc.add(const AuthEventReset());
            Utils.showSnackBar(context, state.responses);
            Navigator.pushNamed(context,RouteNames.verificationScreen,arguments: true).then((value){
              authBloc.add(const AuthEventReset());
            });
          }*/

        },
        child: Padding(
              padding: Utils.all(value: 16.0),
              child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: Utils.all(value:10.0),
                      decoration: BoxDecoration(
                        color: redColor.withOpacity(0.2),
                        borderRadius: Utils.borderRadius(r: 8.0),
                      ),
                      child: const CustomImage(path: KImages.userNotFound),
                    ),
                    const Spacer(),
                    IconButton(onPressed: ()=>Navigator.of(context).pop(), icon: const Icon(Icons.clear)),
                  ],
                ),
                Utils.verticalSpace(16.0),
                const CustomText(text: 'Account not found!!',fontSize: 18.0,fontWeight: FontWeight.w600,color: Color(0xFF2D3034)),
                Utils.verticalSpace(8.0),
                const CustomText(text: 'It looks like there’s no account associated with this phone number. Click continue to open a new account.',fontSize: 12.0,fontWeight: FontWeight.w600,color: Color(0xFF757D85),height: 1.5,),
                Utils.verticalSpace(24.0),
                Row(
                  children: [
                    Expanded(child: PrimaryButton(text: 'Back', onPressed: ()=>Navigator.of(context).pop(),buttonType: ButtonType.outlined,borderColor: grayColor2,bgColor: whiteColor,textColor: blackColor,fontWeight: FontWeight.w700,  isShowIcon: false,)),
                    Utils.horizontalSpace(8.0),
                    Expanded(child: PrimaryButton(
                        text: 'Create New',
                        onPressed: () {
                          context.read<OtpBloc>().add(const OtpEventSendOTP());
                        },
                        buttonType: ButtonType.icon)),
                  ],
                ),
              ],
              ),
            ),
      ),
    );
  }
}
