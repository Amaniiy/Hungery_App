import 'package:flutter/material.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';

class ToppingCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String heroTag; // 👈 إضافة Tag فريد
  final VoidCallback onAdd;

  const ToppingCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onAdd,
    required this.heroTag, // 👈 استقباله هنا
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              blurRadius: 32,
              offset: Offset(0, 12),
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                tag: heroTag, // 👈 استخدام الـ tag الفريد
                child: Image.asset(imagePath, height: 90, fit: BoxFit.cover),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: ColorsApp.productToppingColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                  bottom: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: onAdd,
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
