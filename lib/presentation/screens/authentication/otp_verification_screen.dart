import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../../widgets/custom_app_bar.dart';
import '/presentation/routes/route_packages_name.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/primary_button.dart';

import '../../routes/route_names.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key, required this.isNew});

  final bool isNew;

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
          const CustomText(
              text: "We’ve sent an OTP to mart*****4@gmail.com",
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
              width: Utils.vSize(86.0),
              height: Utils.vSize(55.0),
              textStyle: GoogleFonts.roboto(
                  color: blackColor,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: const Color(0xFFABB0B5)),
                borderRadius: Utils.borderRadius(r: 100.0),
              ),
            ),
            onChanged: (String code) {
              // if (widget.isNewRegistration) {
              //   print('new register code $code');
              //   rBloc.add(RegisterEventCode(code));
              // } else {
              //   passwordCubit.changeCode(code);
              // }
            },
            onCompleted: (String code) {
              // if (widget.isNewRegistration) {
              //   print('new register');
              //   rBloc.add(RegisterEventOtpVerificationSubmit());
              // } else {
              //   passwordCubit.verifyForgotPasswordCode();
              // }
            },
            length: 4,
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
          text: 'Submit',
          onPressed: () => Navigator.pushNamed(
              context, RouteNames.updatePasswordScreen,
              arguments: false),
          buttonType: ButtonType.icon),
    );
  }
}
