import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/widgets/custom_button.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';
import 'package:sonic_app/features/products/ui/widgets/spicy_slider.dart';
import 'package:sonic_app/features/products/ui/widgets/topping_card.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double value = 0.5;

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
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),
              const Gap(30),
              const CustomText(
                text: 'Toppings',
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const Gap(15),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ToppingCard(
                        title: 'Tomato',
                        imagePath: 'assets/images/tomato.png',
                        heroTag: 'tomato_$index', // 👈 Tag unique
                        onAdd: () {},
                      ),
                    );
                  }),
                ),
              ),

              const Gap(30),

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Total", style: TextStyle(color: Colors.black)),
                      Text(
                        "18.19\$",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(text: "Add to Cart", onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
