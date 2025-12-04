import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onAdd,
    this.onMin,
    this.onRemove,
    required this.number,
  });
  final String image, text, desc;
  final Function()? onAdd;
  final Function()? onMin;
  final Function()? onRemove;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(image, width: 100),
                Gap(10),
                CustomText(
                  text: text,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: desc,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onMin,
                      child: CircleAvatar(
                        backgroundColor: ColorsApp.mainColor,
                        child: Icon(Icons.remove, color: Colors.white),
                      ),
                    ),
                    Gap(15),
                    CustomText(
                      text: number.toString(),
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(15),
                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: ColorsApp.mainColor,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 130,
                    decoration: BoxDecoration(
                      color: ColorsApp.mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomText(
                      text: 'Remove',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
