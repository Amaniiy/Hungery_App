import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });
  final String order, taxes, fees, total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkoutWidget("Order", order, false, false),
        Gap(10),
        checkoutWidget("Taxes", taxes, false, false),
        Gap(10),

        checkoutWidget("Delivery fees", fees, false, false),
        Divider(),
        Gap(10),
        checkoutWidget("Total:", total, true, false),
        Gap(10),
        checkoutWidget("Estimated delivery time::", "15 - 30 mins", true, true),
      ],
    );
  }
}

Widget checkoutWidget(title, price, isBold, isSmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        color: isBold ? Colors.black : ColorsApp.helperColor,
        fontSize: isSmall ? 12 : 15,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
      CustomText(
        text: price,
        color: isBold ? Colors.black : ColorsApp.helperColor,
        fontSize: isSmall ? 12 : 15,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
    ],
  );
}
