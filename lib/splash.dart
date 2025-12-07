import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/routing/Routes.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.signUp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(250),
          SvgPicture.asset('assets/images/logo.svg'),
          const Spacer(),
          Image.asset("assets/images/splash.png"),
          const Gap(25),
        ],
      ),
    );
  }
}
