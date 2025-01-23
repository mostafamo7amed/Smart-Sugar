import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/diet/domain/entities/meal_entity.dart';
import 'package:smart_sugar/features/diet/presentation/view/widgets/meal_item_widget.dart';

import 'all_meals_view.dart';

class DietView extends StatelessWidget {
  DietView({super.key});

  final List<MealEntity> meals = [
    MealEntity(
      title: 'Breakfast',
      image: AssetsData.breakfastImage,
    ),
    MealEntity(
      title: 'Lunch',
      image: AssetsData.lunchImage,
    ),
    MealEntity(
      title: 'Dinner',
      image: AssetsData.dinnerImage,
    ),
    MealEntity(
      title: 'Snacks',
      image: AssetsData.snackImage,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Diet Plan', showBackButton: false),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AllMealsView.routeName,arguments: meals[index].title);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5.0),
                child: MealComponent(model: meals[index],),
              ),
            ),
            itemCount: meals.length,
          ),
        ),
    );
  }
}
