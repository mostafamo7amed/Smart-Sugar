
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/centers/domain/entities/sugar_center_entity.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/cached_image.dart';

class SugarCenterItemWidget extends StatelessWidget {
  const SugarCenterItemWidget({
    super.key, required this.sugarCenter, this.addToList=false,
  });

  final SugarCenterEntity sugarCenter;
  final bool? addToList;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: AppColor.whiteColor,
      child: Container(
        width:MediaQuery.of(context).size.width,
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
              cachedImage(sugarCenter.image,AssetsData.placeHolder,
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
                      sugarCenter.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.regular16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: addToList!,
                replacement: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.lightGrayColor,
                  size: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    //add to my list
                    log('add to my list');
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColor.fillColor,
                    child: Icon(
                      Icons.add,
                      color: AppColor.lightGrayColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}