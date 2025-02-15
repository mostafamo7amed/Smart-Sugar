import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/profile/domain/entity/article_entity.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/cached_image.dart';
import '../article_details_view.dart';

class ArticlesHorizontalList extends StatelessWidget {
  const ArticlesHorizontalList({
    super.key,
    required this.articles,
  });
  final List<ArticleEntity> articles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * 0.5,
        child: ListView.builder(
          itemCount: articles.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, ArticlesDetailsView.routeName,
                arguments: articles[index]),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: cachedImage(
                            articles[index].image, AssetsData.placeHolder)
                        .cornerRadiusWithClipRRect(10),
                  ),
                  // Article Title
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      articles[index].title,
                      style: Styles.semiBold13,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
