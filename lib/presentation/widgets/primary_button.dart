import 'package:click_food/presentation/utils/k_images.dart';
import 'package:click_food/presentation/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.maximumSize = const Size(double.infinity, 50.0),
    required this.text,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w700,
    required this.onPressed,
    this.textColor = whiteColor,
    this.bgColor = primaryColor,
    this.borderColor = primaryColor,
    this.minimumSize = const Size(double.infinity, 50.0),
    this.borderRadiusSize = 100.0,
    this.buttonType = ButtonType.elevated,
    this.padding,
    this.icon,
    this.fontFamily,
    this.socialIcon,
  });

  final VoidCallback? onPressed;

  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final ButtonType buttonType;
  final EdgeInsets? padding;
  final Widget? icon;
  final FontWeight fontWeight;
  final String? fontFamily;
  final String? socialIcon;

  @override
  Widget build(BuildContext context) {
    final p = padding ?? Utils.all(value: 0.0);
    final tempIcon = icon ??
        const Icon(
          Icons.email_outlined,
          color: whiteColor,
        );
    final si = socialIcon ?? KImages.google;
    final borderRadius = BorderRadius.circular(borderRadiusSize);
    if (buttonType == ButtonType.icon) {
      return Padding(
        padding: p,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: Row(
            children: [
              const Spacer(),
              CustomText(
                text: text,
                color: textColor,
                fontSize: fontSize.sp,
                height: 1.5.h,
                fontWeight: fontWeight,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              tempIcon,
            ],
          ),
          // label: tempIcon,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(primaryColor),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius)),
            maximumSize: WidgetStateProperty.all(maximumSize),
            minimumSize: WidgetStateProperty.all(minimumSize),
            shadowColor: WidgetStateProperty.all(transparent),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
      );
    } else if (buttonType == ButtonType.outlined) {
      return Padding(
        padding: p,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(bgColor),
            splashFactory: NoSplash.splashFactory,
            shadowColor: WidgetStateProperty.all(transparent),
            overlayColor: WidgetStateProperty.all(transparent),
            elevation: WidgetStateProperty.all(0.0),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(color: borderColor))),
            minimumSize: WidgetStateProperty.all(minimumSize),
            maximumSize: WidgetStateProperty.all(maximumSize),
          ),
          child: Row(
            children: [
              CustomImage(path: si),
              const Spacer(),
              CustomText(
                text: text,
                color: textColor,
                fontSize: fontSize.sp,
                height: 1.5.h,
                fontWeight: fontWeight,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // tempIcon,
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: p,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(bgColor),
            splashFactory: NoSplash.splashFactory,
            shadowColor: WidgetStateProperty.all(transparent),
            overlayColor: WidgetStateProperty.all(transparent),
            elevation: WidgetStateProperty.all(0.0),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: borderRadius)),
            minimumSize: WidgetStateProperty.all(minimumSize),
            maximumSize: WidgetStateProperty.all(maximumSize),
          ),
          child: Padding(
            padding: p,
            child: CustomText(
              text: text,
              color: textColor,
              fontSize: fontSize,
              height: 1.5,
              fontWeight: fontWeight,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }
}

enum ButtonType { elevated, outlined, icon }
