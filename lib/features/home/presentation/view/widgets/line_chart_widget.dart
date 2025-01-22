import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});
  final List<ChartData> chartData = [
    ChartData(DateTime(2025, 1, 21, 18), 80),
    ChartData(DateTime(2025, 1, 21, 21), 96),
    ChartData(DateTime(2025, 1, 22, 3), 150),
    ChartData(DateTime(2025, 1, 22, 9), 120),
    ChartData(DateTime(2025, 1, 22, 12), 60),
    ChartData(DateTime(2025, 1, 22, 15), 120),
    ChartData(DateTime(2025, 1, 22, 18), 140),
  ];



  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('ha'),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 3,
        intervalType: DateTimeIntervalType.hours,
      ),
      primaryYAxis: NumericAxis(
        minimum: 50,
        maximum: 250,
        interval: 50,
        plotBands: <PlotBand>[
          PlotBand(
            isVisible: true,
            start: 80,
            end: 130,
            color: AppColor.primaryColor.withValues(alpha: 0.3),
          ),
        ],
      ),
        series: <CartesianSeries>[
          LineSeries<ChartData, DateTime>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.value,
            width: 1.5,
            markerSettings: MarkerSettings(isVisible: true),
            color: Colors.black,
          ) as CartesianSeries<ChartData, DateTime>,
          ScatterSeries<ChartData, DateTime>(
            dataSource: [chartData.last], // Highlight the last point
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.value,
            markerSettings: MarkerSettings(
              isVisible: true,
              color: Colors.orange,
              borderWidth: 2,
              shape: DataMarkerType.circle,
            ),
          ) as CartesianSeries<ChartData, DateTime>,
        ]
    );
  }
}

class ChartData {
  final DateTime time;
  final double value;

  ChartData(this.time, this.value);
}