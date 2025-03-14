import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/widgets/custom_dialog.dart';
import 'package:smart_sugar/features/admin_feature/domain/emergency_number_entity.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class EmergencyNumberItemWidget extends StatelessWidget {
  const EmergencyNumberItemWidget(
      {super.key,
      this.isManage = false,
      this.onDelete,
      this.emergencyNumberEntity});

  final bool isManage;
  final void Function()? onDelete;
  final EmergencyNumberEntity? emergencyNumberEntity;
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
                      emergencyNumberEntity?.name ?? '',
                      style: Styles.regular16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      emergencyNumberEntity?.number ?? '',
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
                        message:
                            'Are you sure you want to delete this number ?',
                        onConfirm: onDelete,
                      );
                    }
                  },
                  child: SvgPicture.asset(
                      height: 30,
                      isManage ? AssetsData.deleteImage : AssetsData.phoneImage,
                      colorFilter: ColorFilter.mode(
                        isManage
                            ? AppColor.redColor.withValues(alpha: 0.7)
                            : AppColor.lightGrayColor,
                        BlendMode.srcIn,
                      ))),
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
