import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    this.onpressed,
  });

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,

      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
