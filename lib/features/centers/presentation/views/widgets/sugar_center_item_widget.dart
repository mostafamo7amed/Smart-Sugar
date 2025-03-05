import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/admin_feature/domain/sugar_center_model.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/cached_image.dart';

class SugarCenterItemWidget extends StatelessWidget {
  const SugarCenterItemWidget({
    super.key,
    this.sugarCenter,
  });

  final SugarCenterModel? sugarCenter;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: AppColor.whiteColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cachedImage(
                      sugarCenter?.image ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNeJG67ejYXQF6k5Xm9uj3YpwLCd6HVGdBBw&s',
                      AssetsData.placeHolder,
                      fit: BoxFit.fill,
                      width: size.width / 4.5,
                      height: size.width / 4.5)
                  .cornerRadiusWithClipRRect(12),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sugarCenter?.name ?? 'International Medical Center (IMC)',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.regular16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 2,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              SizedBox(
                width: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
