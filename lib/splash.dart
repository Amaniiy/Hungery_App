import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(250),
          SvgPicture.asset('assets/images/logo.svg'),

          Spacer(),
          Image.asset("assets/images/splash.png"),
          Gap(25),
        ],
      ),
    );
  }
}
