import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/profile/domain/entity/article_entity.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/article_card.dart';

class MedicalArticlesView extends StatelessWidget {
  MedicalArticlesView({super.key});
  static const routeName = 'medical-articles';
  // Dummy data for medical articles
  final List<ArticleEntity> articles = [
    ArticleEntity(
        date: '13-06-2023',
        title: 'Understanding Heart Health',
        description:
            'Learn about the importance of heart health and how to maintain it.',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
    ArticleEntity(
      date: '14-06-2023',
        title: 'The Benefits of a Balanced Diet',
        description:
            'Learn about the importance of heart health and how to maintain it.',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
    ArticleEntity(
        date: '15-06-2023',
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
             articleEntity: articles[index],
            );
          },
        ),
      ),
    );
  }
}
