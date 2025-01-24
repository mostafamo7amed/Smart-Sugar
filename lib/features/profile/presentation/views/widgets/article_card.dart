import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/widgets/cached_image.dart';
import '../../../../../core/utils/widgets/custom_button.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String contentUrl;


  const ArticleCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.contentUrl,
  });

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
              child: cachedImage(imageUrl, AssetsData.placeHolder)
                  .cornerRadiusWithClipRRect(10),
            ),
            // Article Title
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: Styles.bold19,
              ),
            ),
            // Article Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                style:
                    Styles.regular13.copyWith(color: AppColor.lightGrayColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                height: 40,
                width: MediaQuery.of(context).size.width * .5,
                color: AppColor.lightGrayColor,
                onPressed: () {
                  launchUrl(Uri.parse(contentUrl));
                },
                text: 'Read More',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
