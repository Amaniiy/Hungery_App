import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

SnackBar authSnackBar(errorMessage) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    margin: EdgeInsets.only(bottom: 35, left: 20, right: 20),
    clipBehavior: Clip.none,
    backgroundColor: Colors.red[900],
    content: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.white),
        Gap(10),
        CustomText(
          text: 'An error occurred: $errorMessage',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    ),
  );
}
