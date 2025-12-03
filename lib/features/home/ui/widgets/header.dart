import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(30),
            SvgPicture.asset(
              'assets/images/logo.svg',
              color: ColorsApp.mainColor,
              height: 35,
            ),
            Gap(5),
            CustomText(
              text: 'Hello,User',
              color: ColorsApp.helperColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: ColorsApp.componentColor,
          radius: 30,
          child: Icon(Icons.person, size: 30, color: ColorsApp.mainColor),
        ),
      ],
    );
  }
}
