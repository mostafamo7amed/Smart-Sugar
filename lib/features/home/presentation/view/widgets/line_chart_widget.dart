import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetChartDataLoadingState,
          child:cubit.chartData.isNotEmpty ? SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('ha'),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 7,
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
                  dataSource: cubit.chartData.isNotEmpty
                      ? cubit.chartData.length > 4
                          ? cubit.chartData.sublist(cubit.chartData.length - 4,
                              cubit.chartData.length)
                          : cubit.chartData.sublist(0, cubit.chartData.length)
                      : null,
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.value,
                  width: 1.5,
                  markerSettings: MarkerSettings(isVisible: true),
                  color: Colors.black,
                ) as CartesianSeries<ChartData, DateTime>,
                ScatterSeries<ChartData, DateTime>(
                  dataSource: cubit.chartData.isNotEmpty
                      ? [cubit.chartData.last]
                      : null, // Highlight the last point
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.value,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    color: Colors.orange,
                    borderWidth: 2,
                    shape: DataMarkerType.circle,
                  ),
                ) as CartesianSeries<ChartData, DateTime>,
              ]): const Center(child: Text('No Sugar Read Found')),
        );
      },
    );
  }
}

class ChartData {
  final DateTime time;
  final double value;

  ChartData(this.time, this.value);
}
