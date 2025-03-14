import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/constants.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/home/presentation/view/read_glucose_view.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/articles_horizontal_list.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/custom_section_field.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/glucose_level_widget.dart';
import 'package:smart_sugar/core/utils/widgets/home_app_bar.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/line_chart_widget.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/user_activity_widget.dart';
import 'articles_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = "home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    UserCubit.get(context).getSugarRead(AppReference.getData(key: userIdKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetSugarReadSuccessState) {
          UserCubit.get(context).analyzeSugarReadings(state.sugarReadList);
          UserCubit.get(context).getChartData(state.sugarReadList);
        }
        if (state is AnalyzeSugarReadSuccessState) {
          UserCubit.get(context).getAllArticles();
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetUserLoadingState ||
              state is GetSugarReadLoadingState ||
              state is GetArticlesLoadingState,
          child: Scaffold(
            appBar: homeAppBar(context),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${cubit.userEntity?.name ?? ''}',
                      style: Styles.bold19,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Last 24 hours'.toUpperCase(),
                            style: Styles.bold16,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserActivityWidget(
                                title: 'Time in Range',
                                value: cubit.timeInRange.toStringAsFixed(0),
                                unit: '%',
                              ),
                              UserActivityWidget(
                                title: 'Last Reading',
                                value: (cubit.lastReading?.sugarRead ?? '0')
                                    .toString(),
                                unit: 'mg/dL',
                              ),
                              UserActivityWidget(
                                title: 'Average',
                                value: (cubit.averageSugarReadings)
                                    .toStringAsFixed(0),
                                unit: 'mg/dL',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Glucose',
                      style: Styles.bold16,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.width * .72,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'mg/dL',
                                      style: Styles.regular11.copyWith(
                                        color: AppColor.lightGrayColor,
                                      ),
                                    ),
                                  )),
                              Expanded(child: LineChartWidget()),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width * .6,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GlucoseLevelWidget(
                                      value: double.parse(
                                          cubit.maxSugarReadings.toString()),
                                      level: 'High',
                                      color: AppColor.redColor,
                                    ),
                                    GlucoseLevelWidget(
                                      value: double.parse(cubit
                                          .averageSugarReadings
                                          .toString()),
                                      level: 'Normal',
                                      color: AppColor.primaryColor,
                                    ),
                                    GlucoseLevelWidget(
                                      value: double.parse(
                                          cubit.minSugarReadings.toString()),
                                      level: 'Low',
                                      color: AppColor.lightGrayColor,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      AppColor.blueColor.withValues(alpha: .15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Diabetes: ',
                                      style: Styles.regular13,
                                    ),
                                    Text(
                                      cubit.userEntity?.diabetesType
                                              .toString() ??
                                          '',
                                      style: Styles.regular13,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CustomButton(
                          height: 40,
                          width: MediaQuery.of(context).size.width * .5,
                          color: AppColor.redColor.withValues(alpha: .5),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ReadGlucoseView.routeName);
                          },
                          text: 'Add Read'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: AppColor.lightGrayColor,
                      thickness: .5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSectionField(
                        title: 'Medical Articles',
                        onTap: () {
                          Navigator.pushNamed(
                              context, MedicalArticlesView.routeName);
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    cubit.articleList.isEmpty
                        ? const Center(child: Text('No Articles'))
                        : ArticlesHorizontalList(
                            articles: cubit.articleList,
                          ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
