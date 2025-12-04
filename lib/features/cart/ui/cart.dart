import 'package:flutter/material.dart';
import 'package:sonic_app/core/widgets/custom_button.dart';
import 'package:sonic_app/features/cart/ui/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final int itemCount = 7;
  late List<int> quantities;

  @override
  void initState() {
    quantities = List.generate(20, (_) => 1);
    super.initState();
  }

  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void onMin(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 45, bottom: 10),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return CartItem(
              image: 'assets/images/card.png',
              text: 'Hamburger',
              desc: 'Veggie Burger',
              number: quantities[index],
              onAdd: () => onAdd(index),

              onMin: () => onMin(index),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Total", style: TextStyle(color: Colors.black)),
                Text(
                  "99.19\$",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(text: "Checkout", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
