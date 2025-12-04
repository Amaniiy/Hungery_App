import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/product.png", height: 240),
        Spacer(),
        Column(
          children: [
            CustomText(
              text:
                  "Customize Your Burger\n to Your Tastes.\n Ultimate Experience",
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            Slider(
              value: widget.value,
              onChanged: widget.onChanged,
              activeColor: ColorsApp.mainColor,
              inactiveColor: Colors.grey[300],
            ),
            Row(children: [Text("🥶"), Gap(100), Text("🌶️")]),
          ],
        ),
      ],
    );
  }
}
