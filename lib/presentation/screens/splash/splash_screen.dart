import '../../routes/route_names.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.authOptionScreen, (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: Utils.mediaQuery(context).height,
        width: Utils.mediaQuery(context).width,
        child: const CustomImage(path: KImages.splashBg),
      ),
    );
  }
}
