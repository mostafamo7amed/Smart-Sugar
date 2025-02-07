import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';

import '../../../../core/helper_functions/load_diabetes_data.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/cached_image.dart';
import '../../domain/entities/diabetes_data.dart';
import '../../domain/entities/meal_entity.dart';

class MealDetailsView extends StatefulWidget {
  const MealDetailsView({super.key, required this.mealEntity});
  static const routeName = 'mealDetailsView';
  final MealEntity mealEntity;

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {

  int selectedIndex = 0;
  late Future<DiabetesData> diabetesData;
  @override
  void initState() {
    diabetesData = loadDiabetesData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, title: 'Meal Details'),
      body: FutureBuilder(
        future: diabetesData,
        builder:(context, snapshot) =>  SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height * .4,
                      child: cachedImage(
                        radius: 1,
                        widget.mealEntity.image,AssetsData.placeHolder,
                      ).cornerRadiusWithClipRRect(1),
                    ),
                    mBlackEffect(size.width, size.height * .4,radiusValue: 1),
                    //dietCategoryModel.image
                    Positioned(
                      top: size.height * .25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.mealEntity.title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Styles.regular16
                                      .copyWith(color: AppColor.whiteColor),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Container(
                                padding: const EdgeInsets.all(4),
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: Colors.grey.shade100.withValues(alpha: 0.2)),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AssetsData.clockIcon,
                                      color: AppColor.whiteColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${widget.mealEntity.time} min",
                                      style: Styles.regular13
                                          .copyWith(color: AppColor.whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width,
                      margin: EdgeInsets.only(top: size.height * .32),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  decoration:
                                  BoxDecoration(color: AppColor.whiteColor),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AssetsData.caloriesIcon,
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${widget.mealEntity.calories} kcal",
                                        style: Styles.regular13,
                                      ),
                                      Text(
                                        'Calories',
                                        style: Styles.regular13.copyWith(
                                            color: AppColor.lightGrayColor),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 80,
                                  decoration:
                                  BoxDecoration(color: AppColor.whiteColor),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AssetsData.carbsIcon,
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${widget.mealEntity.carbs} g",
                                        style: Styles.regular13,
                                      ),
                                      Text(
                                        'Carbs',
                                        style: Styles.regular13.copyWith(
                                            color: AppColor.lightGrayColor),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 80,
                                  decoration:
                                  BoxDecoration(color: AppColor.whiteColor),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AssetsData.fatIcon,
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${widget.mealEntity.fat} g",
                                        style: Styles.regular13,
                                      ),
                                      Text(
                                        'Fat',
                                        style: Styles.regular13.copyWith(
                                            color: AppColor.lightGrayColor),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  height: 80,
                                  decoration:
                                  BoxDecoration(color: AppColor.whiteColor),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AssetsData.proteinIcon,
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${widget.mealEntity.protein} g",
                                        style: Styles.regular13,
                                      ),
                                      Text(
                                        'Protein',
                                        style: Styles.regular13.copyWith(
                                            color: AppColor.lightGrayColor),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColor.grayColor, // Color of the divider
                            thickness: 1.0, // Thickness of the line in pixels
                            height: 16.0,
                            indent: 21.0,
                            endIndent: 21.0, // Space after the divider line
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 0;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ingredients',
                                        style: Styles.semiBold13.copyWith(
                                          color: selectedIndex == 0
                                              ? AppColor.blackColor
                                              : AppColor.lightGrayColor,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        height: 2,
                                        width: (size.width - 50) / 2,
                                        color: selectedIndex == 0
                                            ? AppColor.blackColor
                                            : AppColor.lightGrayColor,
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 1;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Instructions',
                                        style: Styles.semiBold13.copyWith(
                                          color: selectedIndex == 1
                                              ? AppColor.blackColor
                                              : AppColor.lightGrayColor,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        height: 2,
                                        width: (size.width - 50) / 2,
                                        color: selectedIndex == 1
                                            ? AppColor.blackColor
                                            : AppColor.lightGrayColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: size.width,
                                child: Text(
                                  textAlign: TextAlign.start,
                                  selectedIndex == 0
                                      ? widget.mealEntity.ingredients!
                                      : widget.mealEntity.description!,
                                  style: Styles.regular16
                                      .copyWith(color: AppColor.lightGrayColor,),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
