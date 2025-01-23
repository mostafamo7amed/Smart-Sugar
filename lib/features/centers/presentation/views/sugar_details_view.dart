import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/build_app_bar.dart';

class SugarDetailsView extends StatelessWidget {
  const SugarDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Sugar Details'),
      body: const Center(child: Text('Sugar Details')),
    );
  }
}
