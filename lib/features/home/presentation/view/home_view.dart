import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/features/home/presentation/view/read_glucose_view.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/glucose_level_widget.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/home_app_bar.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/line_chart_widget.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/user_activity_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Sarah',
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
                          value: '58',
                          unit: '%',
                        ),
                        UserActivityWidget(
                          title: 'Last Reading',
                          value: '194',
                          unit: 'mg/dL',
                        ),
                        UserActivityWidget(
                          title: 'Average',
                          value: '187',
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GlucoseLevelWidget(
                                value: 200,
                                level: 'High',
                                color: AppColor.redColor,
                              ),
                              GlucoseLevelWidget(
                                value: 120,
                                level: 'Normal',
                                color: AppColor.primaryColor,
                              ),
                              GlucoseLevelWidget(
                                value: 60,
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
                            color: AppColor.blueColor.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Pills',
                                style: Styles.regular13,
                              ),
                              Spacer(),
                              Text(
                                '3 Taken',
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
                      Navigator.pushNamed(context, ReadGlucoseView.routeName);
                    },
                    text: 'Add Read'),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .5,
                    color: AppColor.primaryColor,
                    onPressed: () {},
                    text: 'Emergency number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
