import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import '../../../../../core/utils/app_manager/app_assets.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/cached_image.dart';
import '../../../domain/entities/meal_entity.dart';

class MealComponent extends StatelessWidget {
  final bool isGrid;
  final MealEntity model;
  const MealComponent({super.key, this.isGrid = false, required this.model});

  @override
  Widget build(BuildContext context) {
    double width =
    isGrid == true ? (context.width() - 30) / 2 : context.width();
    double height =
    isGrid == true ? (context.width() - 10) / 2 : context.width()*.45;

    return SizedBox(
      width: width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          cachedImage(model.image,AssetsData.placeHolder,
              fit: BoxFit.fill, width: width, height: height)
              .cornerRadiusWithClipRRect(16),
          6.height,
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.white70.withValues(alpha: 0.8)),
            child: Text(model.mealType.validate(),
                style: Styles.regular16
                    .copyWith(color: AppColor.blackColor),
                textAlign: TextAlign.start,
                maxLines: 2),
          ),
        ],
      ),
    );
  }
}