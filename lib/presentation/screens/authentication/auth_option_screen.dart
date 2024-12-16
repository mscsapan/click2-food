import 'package:flutter/material.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widgets/custom_image.dart';
import '/presentation/widgets/custom_text.dart';
import '/presentation/widgets/primary_button.dart';

import '../../routes/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';

class AuthOptionScreen extends StatelessWidget {
  const AuthOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Utils.verticalSpace(6.0),
          SizedBox(
            height: Utils.mediaQuery(context).height * 0.4,
            width: Utils.mediaQuery(context).width,
            child:  Stack(
              fit: StackFit.expand,
              children: [
                const CustomImage(
                  path: KImages.loginTopImage,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    left: 10.0,
                    top: Utils.mediaQuery(context).height * 0.06,
                    child: IconButton(onPressed: ()=> debugPrint('clear'), icon: const Icon(Icons.clear,size: 28.0)))
              ],
            ),
          ),
          Padding(
            padding: Utils.symmetric(),
            child: Column(
              children: [
                const CustomText(text: 'Welcome back 👋',fontSize: 24.0,fontWeight: FontWeight.w700),
                Utils.verticalSpace(56.0),
                const CustomText(text: 'Choose your log in method',fontSize: 16.0,fontWeight: FontWeight.w700,color: grayColor),
                Utils.verticalSpace(16.0),
                PrimaryButton(text: 'Continue with Email', onPressed: ()=>Navigator.pushNamed(context,RouteNames.loginScreen),buttonType: ButtonType.icon),
                Utils.verticalSpace(12.0),
                Row(
                  children: [
                    const Expanded(child: Divider(color: grayColor2,height: 0.5)),
                    Padding(
                      padding: Utils.symmetric(h: 6.0),
                      child: const CustomText(text: 'or',fontSize: 14.0,fontWeight: FontWeight.w500,color: grayColor,),
                    ),
                    const Expanded(child: Divider(color: grayColor2,height: 1.0)),
                  ],
                ),
                Utils.verticalSpace(12.0),
                PrimaryButton(text: 'Continue with Google', onPressed: (){},buttonType: ButtonType.outlined,borderColor: grayColor2,bgColor: whiteColor,textColor: blackColor,fontWeight: FontWeight.w700,),
                Utils.verticalSpace(8.0),
                PrimaryButton(text: 'Continue with Apple', onPressed: (){},buttonType: ButtonType.outlined,borderColor: grayColor2,bgColor: whiteColor,textColor: blackColor,fontWeight: FontWeight.w700,socialIcon: KImages.apple,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
