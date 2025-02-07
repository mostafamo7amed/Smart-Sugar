import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/diet/domain/entities/diabetes_data.dart';
import 'package:smart_sugar/features/diet/domain/entities/meal_entity.dart';
import 'package:smart_sugar/features/diet/presentation/view/meal_details_view.dart';
import 'package:smart_sugar/features/diet/presentation/view/widgets/meal_item_widget.dart';

class DietView extends StatelessWidget {
  const DietView({super.key, required this.mealPlans});
  static const routeName = 'dietView';

  final MealPlan mealPlans;

  @override
  Widget build(BuildContext context) {
    final List<MealEntity> meals = [
      MealEntity(
        mealType: 'Breakfast',
        title: mealPlans.breakfast,
        image: AssetsData.breakfastImage,
      ),
      MealEntity(
        mealType: 'Lunch',
        title: mealPlans.lunch,
        image: AssetsData.lunchImage,
      ),
      MealEntity(
        mealType: 'Dinner',
        title: mealPlans.dinner,
        image: AssetsData.dinnerImage,
      ),
      MealEntity(
        mealType: 'Snacks',
        title: mealPlans.snacks,
        image: AssetsData.snackImage,
      )
    ];

    return Scaffold(
      appBar: buildAppBar(context, title: '${mealPlans.day} Plan'),
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MealDetailsView.routeName,
                  arguments: MealEntity(
                    id: 1,
                    title: mealPlans.breakfast,
                    image: 'assets/images/breakfast.png',
                    description: 'This meal is good for you',
                    calories: '135',
                    carbs: '13.5',
                    fat: '2.5',
                    protein: '10.9',
                    ingredients:
                    '1.5 cup of water\n1 cup of milk\n1 cup of sugar\n1 cup of chocolate\n1 cup of yogurt\n1 cup of fruits\n1 cup of vegetables',
                    mealType: 'Breakfast',
                    time: '32',
                  ),
                );
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
