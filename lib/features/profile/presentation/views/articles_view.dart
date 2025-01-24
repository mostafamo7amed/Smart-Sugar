import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/profile/domain/entity/article_entity.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/article_card.dart';

class MedicalArticlesView extends StatelessWidget {
  MedicalArticlesView({super.key});
  static const routeName = 'medical-articles';
  // Dummy data for medical articles
  final List<ArticleEntity> articles = [
    ArticleEntity(
        contentUrl:
            'https://www.heartfoundation.org.au/healthy-living/keeping-your-heart-healthy',
        title: 'Understanding Heart Health',
        description:
            'Learn about the importance of heart health and how to maintain it.',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
    ArticleEntity(
        contentUrl: 'https://www.cdc.gov/nutrition/php/resources/healthy-eating-benefits-for-adults.html',
        title: 'The Benefits of a Balanced Diet',
        description:
            'Learn about the importance of heart health and how to maintain it.',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
    ArticleEntity(
        contentUrl: 'https://www.mayoclinichealthsystem.org/hometown-health/speaking-of-health/5-tips-to-manage-stress',
        title: 'Managing Stress Effectively',
        description:
            'Learn about the importance of heart health and how to maintain it.',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Medical Articles'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return ArticleCard(
              title: articles[index].title,
              description: articles[index].description,
              imageUrl: articles[index].image,
              contentUrl: articles[index].contentUrl,
            );
          },
        ),
      ),
    );
  }
}
