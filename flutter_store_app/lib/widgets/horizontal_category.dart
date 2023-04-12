import 'package:flutter/material.dart';
import 'package:flutter_store_app/data/model/category.dart';
import 'package:flutter_store_app/widgets/cached_image.dart';

class CategoryHorizontalItem extends StatelessWidget {
  final Category category;
  CategoryHorizontalItem(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'ff${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: ShapeDecoration(
                color: Color(hexColor),
                shadows: [
                  BoxShadow(
                    color: Color(hexColor),
                    blurRadius: 25,
                    spreadRadius: -12.0,
                    offset: const Offset(0.0, 15.0),
                  ),
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: CachedImage(imageUrl: category.icon),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          category.title ?? 'محصول',
          style: const TextStyle(fontFamily: 'SB', fontSize: 12),
        ),
      ],
    );
  }
}
