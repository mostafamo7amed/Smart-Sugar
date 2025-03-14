import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/helper_functions/load_diabetes_data.dart';
import 'package:smart_sugar/features/diet/domain/entities/diabetes_data.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import 'diet_view.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({super.key});

  @override
  State<TrainingView> createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  late Future<DiabetesData> diabetesData;
  @override
  void initState() {
    diabetesData = loadDiabetesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          appBar:
              buildAppBar(context, title: 'Diet Plan', showBackButton: false),
          body: FutureBuilder<DiabetesData>(
            future: diabetesData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTypeSection(
                          '${cubit.userEntity?.diabetesType} Diabetes',
                          cubit.userEntity?.diabetesType == 'Type 1'
                              ? data.type1
                              : data.type2),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        );
      },
    );
  }
}

Widget _buildTypeSection(String title, DiabetesType type) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Styles.bold23.copyWith(color: AppColor.blueColor)),
              SizedBox(height: 16),
              Text('Important Tips',
                  style: Styles.bold19.copyWith(color: AppColor.pinkColor)),
              ...type.importantTips.entries.map((e) =>
                  Text('${e.key}. ${e.value}', style: Styles.semiBold13)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Exercises',
                  style: Styles.bold19.copyWith(color: AppColor.primaryColor)),
              ...type.suitableExercises.entries.map((e) =>
                  Text('${e.key}. ${e.value}', style: Styles.semiBold13)),
              SizedBox(height: 16),
              Text('Note:',
                  style: Styles.bold19.copyWith(color: AppColor.redColor)),
              Text(type.note, style: Styles.semiBold13),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Meal Plan',
                      style:
                          Styles.bold19.copyWith(color: AppColor.orangeColor)),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColor.orangeColor,
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, DietView.routeName,
                          arguments: type.mealPlans[index]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        type.mealPlans[index].day,
                        style: Styles.semiBold13,
                      ),
                    ),
                  ),
                  itemCount: type.mealPlans.length,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
