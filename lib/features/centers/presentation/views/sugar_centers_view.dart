import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/sugar_center_item_widget.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class SugarCentersView extends StatelessWidget {
  const SugarCentersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Sugar Centers'),
      floatingActionButton: CustomButton(
        width: MediaQuery.of(context).size.width * .65,
        height: 40,
        onPressed: () {},
        text: 'Add Neighborhood Hospital',
        color: AppColor.redColor.withValues(alpha: .5),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              log('click all sugar centers');
            },
            child: SugarCenterItemWidget(),
          ),
          itemCount: 8,
        ),
      ),
    );
  }
}
