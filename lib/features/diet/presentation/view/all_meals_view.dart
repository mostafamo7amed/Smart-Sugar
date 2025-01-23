import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/diet/presentation/view/widgets/meal_item_widget.dart';

import '../../domain/entities/meal_entity.dart';
import 'meal_details_view.dart';

class AllMealsView extends StatelessWidget {
  const AllMealsView({super.key, required this.mealType});
  static const routeName = 'allMealsView';

  final String mealType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context, title: '$mealType Meals', showBackButton: true),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                MealDetailsView.routeName,
                arguments: MealEntity(
                  id: 1,
                  title: mealType,
                  image: 'assets/images/${mealType.toLowerCase()}.png',
                  description: 'This meal is good for you',
                  calories: '135',
                  carbs: '13.5',
                  fat: '2.5',
                  protein: '10.9',
                  ingredients:
                      '1.5 cup of water\n1 cup of milk\n1 cup of sugar\n1 cup of chocolate\n1 cup of yogurt\n1 cup of fruits\n1 cup of vegetables',
                  mealType: mealType,
                  time: '32',
                ),
              );
            },
            child: MealComponent(
              isGrid: true,
              model: MealEntity(
                id: 1,
                title: mealType,
                image: 'assets/images/${mealType.toLowerCase()}.png',
                description: 'This meal is good for you',
                calories: '135',
                carbs: '13.5',
                fat: '2.5',
                protein: '10.9',
                ingredients:
                    '1.5 cup of water\n1 cup of milk\n1 cup of sugar\n1 cup of chocolate\n1 cup of yogurt\n1 cup of fruits\n1 cup of vegetables',
              ),
            ),
          );
        },
      ),
    );
  }
}
