import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_divider.dart';

class DistrictItemWidget extends StatelessWidget {
  const DistrictItemWidget(
      {super.key, this.groupValue, this.value, this.districtName});
  final int? groupValue;
  final int? value;
  final String? districtName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                activeColor: AppColor.primaryColor,
                value: value,
                groupValue: groupValue,
                onChanged: (value) {},
              ),
              Expanded(
                  child: Text(
                districtName!,
                style: Styles.semiBold16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          CustomDivider(),
        ],
      ),
    );
  }
}
