import 'package:flutter/material.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

class CategoryItem extends StatefulWidget {
  CategoryItem({
    super.key,
    required this.categories,
    required this.selectedIndex,
  });
  final List categories;
  final int selectedIndex;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedIndex == index
                    ? ColorsApp.mainColor
                    : ColorsApp.componentColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: CustomText(
                text: widget.categories[index],
                color: selectedIndex == index
                    ? Colors.white
                    : ColorsApp.helperColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }
}
