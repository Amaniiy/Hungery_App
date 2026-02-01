import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';
import 'package:sonic_app/core/widgets/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });

  final String image;
  final String text;
  final String desc;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180, // عرض الكارد
      height: 260, // طول الكارد
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              //خلينا نجيب الصورة من الانترنت بدل الجهاز لانها هتتغير مع ال API network image
              child: Image.asset(
                image,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomText(
                    text: text,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Gap(4),

                  // Description
                  CustomText(
                    text: desc,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Gap(8),

                  // Rate + Favorite
                  Row(
                    children: [
                      CustomText(
                        text: '$rate ⭐',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(),

                      Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: ColorsApp.mainColor,
                      ),
                    ],
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
