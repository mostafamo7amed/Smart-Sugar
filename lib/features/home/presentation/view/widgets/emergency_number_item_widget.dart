import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/widgets/custom_dialog.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class EmergencyNumberItemWidget extends StatelessWidget {
  const EmergencyNumberItemWidget({super.key, this.isManage = false});

  final bool isManage;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: AppColor.whiteColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(12),
        )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColor.fillColor,
                child: SvgPicture.asset(AssetsData.profileIcon),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Ambulanceman',
                      style: Styles.regular16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '+123456789',
                      style: Styles.regular16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.lightGrayColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (isManage) {
                      customDialog(
                        context: context,
                        message: 'Are you sure you want to delete this number ?',
                        onConfirm: () {},
                      );
                    }
                  },
                  child: Icon(
                    size: 30,
                    isManage ? Icons.delete : Icons.call,
                    color: isManage
                        ? AppColor.redColor.withValues(alpha: 0.7)
                        : AppColor.lightGrayColor,
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
