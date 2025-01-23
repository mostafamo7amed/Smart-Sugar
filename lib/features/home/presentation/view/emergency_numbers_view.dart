import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/emergency_number_item_widget.dart';

import '../../../../core/helper_functions/url_lancher.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class EmergencyNumbersView extends StatelessWidget {
  const EmergencyNumbersView({super.key});
  static const routeName = 'emergency-numbers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Emergency Numbers'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              log('call');
              launchPhoneDialer("+20101111111");
            },
            child: EmergencyNumberItemWidget(),
          ),
          itemCount: 3,
        ),
      ),
    );
  }
}
