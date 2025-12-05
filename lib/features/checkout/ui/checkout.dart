import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_button.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/features/checkout/ui/widgets/order_details.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedMethod = "cash";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Order summary",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              Gap(10),
              OrderDetails(
                order: '18.19',
                taxes: '0.3',
                fees: '1.5',
                total: '20.19',
              ),
              Gap(50),
              CustomText(
                text: "Payment methods",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              Gap(15),
              ListTile(
                onTap: () => setState(() => selectedMethod = 'cash'),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                tileColor: ColorsApp.productToppingColor,
                leading: Image.asset("assets/images/cash.png"),
                title: CustomText(
                  text: "Cash on Delivery",
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "cash",
                  groupValue: selectedMethod,
                  onChanged: (value) => setState(() => selectedMethod = value!),
                ),
              ),
              Gap(15),
              ListTile(
                onTap: () => setState(() => selectedMethod = 'visa'),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                tileColor: ColorsApp.componentColor,
                leading: Image.asset("assets/images/visa.png"),
                subtitle: CustomText(
                  text: "3566 **** **** 0505",
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                title: CustomText(
                  text: "Debit card",
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),

                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "visa",
                  groupValue: selectedMethod,
                  onChanged: (value) => setState(() => selectedMethod = value!),
                ),
              ),
              Gap(5),
              Row(
                children: [
                  Checkbox(
                    activeColor: ColorsApp.mainColor,
                    value: true,
                    onChanged: (v) {},
                  ),
                  CustomText(
                    text: 'Save card details for future payments',
                    color: ColorsApp.helperColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 20, offset: Offset(0, 1)),
          ],
        ),
        height: 95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Total", style: TextStyle(color: Colors.black)),
                  Text(
                    "18.19\$",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomButton(
                text: "Pay Now",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: ColorsApp.mainColor,
                                  child: Icon(
                                    Icons.check_outlined,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                CustomText(
                                  text: "Success!",
                                  color: ColorsApp.mainColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),

                                const SizedBox(height: 8),

                                CustomText(
                                  text:
                                      "Your payment was successful.\nA receipt has been sent\nto your email.",
                                  color: ColorsApp.helperColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),

                                const SizedBox(height: 28),

                                CustomButton(
                                  text: "Go Back",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
