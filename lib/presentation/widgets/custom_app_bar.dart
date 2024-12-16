import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/k_images.dart';
import '../utils/utils.dart';
import 'custom_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  // const CustomAppBar({
  //   super.key,
  //   required this.title,
  //   this.isShowBackButton = true,
  //   this.textSize = 22.0,
  //   this.fontWeight = FontWeight.w700,
  //   this.textColor = blackColor,
  // });

  // final String title;
  // final bool isShowBackButton;
  // final double textSize;
  // final FontWeight fontWeight;
  // final Color textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      leading: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const CustomImage(path: KImages.backIcon),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.maybePop(context),
      child: Container(
        height: Utils.vSize(48.0),
        width: Utils.hSize(48.0),
        alignment: Alignment.center,
        margin: Utils.only(right: 30.0),
        decoration: BoxDecoration(
          borderRadius: Utils.borderRadius(),
          border: Border.all(color: grayColor.withOpacity(0.5)),
        ),
        child: Padding(
          padding: Utils.only(left: 8.0),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
