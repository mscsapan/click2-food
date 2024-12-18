import 'package:click_food/data/models/auth/auth_state_model.dart';
import 'package:click_food/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../widgets/custom_app_bar.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.isNew});

  final bool isNew;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    debugPrint('current-state ${authBloc.state.authState}');
    authBloc.add(const AuthAddOTP('')); //..add(const AuthEventReset());
    debugPrint('current-state ${authBloc.state.authState}');
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
              child: CustomImage(path: KImages.otpIcon, fit: BoxFit.cover)),
          Utils.verticalSpace(16.0),
          const CustomText(
              text: 'OTP verification',
              fontSize: 24.0,
              fontWeight: FontWeight.w700),
          Utils.verticalSpace(8.0),
           CustomText(
              text: "We’ve sent an OTP to ${Utils.obfuscateEmail(authBloc.state.email)}",
              fontWeight: FontWeight.w500,
              color: grayColor3),
          Utils.verticalSpace(24.0),
          const CustomText(
              text: "Please enter the code below:",
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D636A)),
          Utils.verticalSpace(12.0),
          Pinput(
            defaultPinTheme: PinTheme(
              width: Utils.vSize(60.0),
              height: Utils.vSize(55.0),
              textStyle: GoogleFonts.roboto(
                  color: blackColor,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: const Color(0xFFABB0B5)),
                borderRadius: Utils.borderRadius(r: 10.0),
              ),
            ),
            onChanged: (String code) {
              authBloc.add(AuthAddOTP(code));
              // if (widget.isNewRegistration) {
              //   print('new register code $code');
              //   rBloc.add(RegisterEventCode(code));
              // } else {
              //   passwordCubit.changeCode(code);
              // }
            },
            onCompleted: (String code) {
              // debugPrint('printt $code');

              // if (widget.isNewRegistration) {
              //   print('new register');
              //   rBloc.add(RegisterEventOtpVerificationSubmit());
              // } else {
              //   passwordCubit.verifyForgotPasswordCode();
              // }
            },
            length: 6,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Utils.verticalSpace(16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CustomText(
                      text: "Don’t receive the otp?",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Color(0xFF5D636A)),
                  Utils.horizontalSpace(8.0),
                  const CustomText(
                      text: "Resend OTP",
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                      color: primaryColor),
                ],
              ),
              TimerCountdown(
                format: CountDownTimerFormat.secondsOnly,
                enableDescriptions: false,
                spacerWidth: 6.0,
                timeTextStyle: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  color: blackColor,
                  fontWeight: FontWeight.w700,
                ),
                colonsTextStyle: GoogleFonts.urbanist(
                  fontSize: 12.0,
                  color: blackColor,
                  fontWeight: FontWeight.w700,
                ),
                endTime: DateTime.now().add(
                  const Duration(minutes: 1),
                ),
                onEnd: () {
                  debugPrint('finish');
                  // setState(() => finishTime = false);
                },
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: _submitButton(context),
    );
  }

  Widget _submitButton(BuildContext context) {
    // final sCubit = context.read<AddAdditionalCubit>();
    return BlocConsumer<AuthBloc, AuthStateModel>(
      listener: (context, auth) {
        final state = auth.authState;
        if (state is AuthStateError) {
          Utils.errorSnackBar(context, state.message);
        } else if (state is AuthStateOTPVerify) {

          authBloc.add(const AuthEventReset());

          if(state.responses == 'OTP has not Matched.' || state.responses.contains('not')){
            Utils.showSnackBar(context, state.responses);
          }else{
            Utils.showSnackBar(context, state.responses);

            Navigator.pushNamed(context, RouteNames.signUpScreen);
          }
        }
      },
      builder: (context, states) {
        final state = states.authState;
        final isValidOtp = states.otp.isNotEmpty && states.otp.length == 6;
        return Container(
          padding: Utils.only(
            left: 20.0,
            right: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          margin: Utils.symmetric(h: 0.0, v: 20.0).copyWith(bottom: 24.0),
          child: state is AuthStateLoading? _loading(): PrimaryButton(
              text: 'Submit',
              bgColor: isValidOtp ? primaryColor : grayColor,
              onPressed: () {
                if (isValidOtp) {
                  authBloc.add(const AuthEventVerifyOtp());
                }
              },
              buttonType: ButtonType.icon),
        );
      },
    );
  }

  Widget _loading() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [LoadingWidget()],
    );
  }
}
