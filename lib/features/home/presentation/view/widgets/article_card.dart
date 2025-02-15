import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/custom_dialog.dart';
import 'package:smart_sugar/features/profile/domain/entity/article_entity.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/widgets/cached_image.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../article_details_view.dart';

class ArticleCard extends StatelessWidget {


  const ArticleCard({
    super.key,
    required this.articleEntity, this.isManage=false,
  });
  final ArticleEntity articleEntity;
  final bool isManage;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.whiteColor,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Article Image
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .19,
              child: cachedImage(articleEntity.image, AssetsData.placeHolder)
                  .cornerRadiusWithClipRRect(10),
            ),
            // Article Title
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                articleEntity.title,
                style: Styles.bold19,
              ),
            ),
            // Article Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                articleEntity.description,
                style:
                    Styles.regular13.copyWith(color: AppColor.lightGrayColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if(!isManage)
                  CustomButton(
                    height: 40,
                    width: isManage?MediaQuery.of(context).size.width * .3:MediaQuery.of(context).size.width * .5,
                    color: AppColor.lightGrayColor,
                    onPressed: () {
                      Navigator.pushNamed(context, ArticlesDetailsView.routeName,arguments: articleEntity);
                    },
                    text: 'Read More',
                  ),
                  if(isManage)
                  CustomButton(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .3,
                    color: AppColor.redColor,
                    onPressed: () {
                      customDialog(
                        context: context,
                        message: 'Are you sure you want to delete ${articleEntity.title}?',
                        onConfirm: () {},
                      );
                    },
                    text: 'Delete',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
