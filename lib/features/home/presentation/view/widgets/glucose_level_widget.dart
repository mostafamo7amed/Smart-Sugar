import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class GlucoseLevelWidget extends StatelessWidget {
  const GlucoseLevelWidget({
    super.key,
    required this.level,
    required this.value,
    required this.color,
  });
  final String level;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(),
        Text(
          '${value.round()} \nmg/dL',
          textAlign: TextAlign.center,
          style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),
        ),
        Container(
          width: 30,
          height: level == 'High'
              ? MediaQuery.of(context).size.height * 0.15
              : level == "Normal"
                  ? MediaQuery.of(context).size.height * 0.1
                  : MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Text(
          level,
          style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
