import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';

import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class GlucoseReportView extends StatelessWidget {
  GlucoseReportView({super.key});
  static const routeName = 'glucose-report';

  final List<GlucoseMeasurement> measurements = [
    GlucoseMeasurement(
        value: 95, dateTime: DateTime(2023, 10, 1), result: 'Low'),
    GlucoseMeasurement(
        value: 100, dateTime: DateTime(2023, 10, 5), result: 'Normal'),
    GlucoseMeasurement(
        value: 110, dateTime: DateTime(2023, 10, 10), result: 'Normal'),
    GlucoseMeasurement(
        value: 105, dateTime: DateTime(2023, 10, 15), result: 'Normal'),
    GlucoseMeasurement(
        value: 98, dateTime: DateTime(2023, 10, 20), result: 'Normal'),
    GlucoseMeasurement(
        value: 120, dateTime: DateTime(2023, 10, 25), result: 'High'),
    GlucoseMeasurement(
        value: 115, dateTime: DateTime(2023, 10, 30), result: 'Normal'),
    GlucoseMeasurement(
        value: 115, dateTime: DateTime(2023, 10, 30), result: 'Normal'),
    GlucoseMeasurement(
        value: 115, dateTime: DateTime(2023, 10, 30), result: 'Normal'),
  ];

  // Calculate average, highest, and lowest glucose values
  double get averageGlucose =>
      measurements.map((m) => m.value).reduce((a, b) => a + b) /
      measurements.length;
  int get highestGlucose =>
      measurements.map((m) => m.value).reduce((a, b) => a > b ? a : b);
  int get lowestGlucose =>
      measurements.map((m) => m.value).reduce((a, b) => a < b ? a : b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Glucose Report'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Report of the last month', style: Styles.bold19),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem(
                      'Average', '${averageGlucose.toStringAsFixed(1)} mg/dL'),
                  _buildSummaryItem('Highest', '$highestGlucose mg/dL'),
                  _buildSummaryItem('Lowest', '$lowestGlucose mg/dL'),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: measurements.length,
              itemBuilder: (context, index) {
                final measurement = measurements[index];
                final isHighest = measurement.value == highestGlucose;
                final isLowest = measurement.value == lowestGlucose;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: isHighest
                        ? AppColor.redColor.withValues(alpha: 0.2)
                        : isLowest
                            ? AppColor.blueColor.withValues(alpha: 0.2)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isHighest
                          ? AppColor.redColor
                          : isLowest
                              ? AppColor.blueColor
                              : AppColor.lightGrayColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      '${measurement.value} mg/dL',
                      style: TextStyle(
                        fontWeight: isHighest || isLowest
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      '${measurement.dateTime.day}/${measurement.dateTime.month}/${measurement.dateTime.year}',
                    ),
                    trailing: isHighest
                        ? Text(
                            measurement.result,
                            style: Styles.bold16
                                .copyWith(color: AppColor.redColor),
                          )
                        : isLowest
                            ? Text(
                                measurement.result,
                                style: Styles.bold16
                                    .copyWith(color: AppColor.blueColor),
                              )
                            : Text(
                                measurement.result,
                                style: Styles.bold16
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class GlucoseMeasurement {
  final int value;
  final DateTime dateTime;
  final String result;

  GlucoseMeasurement(
      {required this.value, required this.dateTime, required this.result});
}
