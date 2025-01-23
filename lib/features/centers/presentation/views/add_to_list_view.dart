import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:smart_sugar/features/centers/domain/entities/sugar_center_entity.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/sugar_center_item_widget.dart';

import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class AddToListView extends StatelessWidget {
  const AddToListView({super.key});
  static const routeName = 'addToListView';

  @override
  Widget build(BuildContext context) {
    List<SugarCenterEntity> sugarCenters = [
      SugarCenterEntity(
        name: 'International Medical Center (IMC)',
        id: '1',
        district: 'Al-Rawdah District',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNeJG67ejYXQF6k5Xm9uj3YpwLCd6HVGdBBw&s',
        phoneNumber: '+05012345678',
      ),
      SugarCenterEntity(
        name: 'International Medical Center (IMC)',
        id: '1',
        district: 'Al-Rawdah District',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNeJG67ejYXQF6k5Xm9uj3YpwLCd6HVGdBBw&s',
        phoneNumber: '+05012345678',
      ),
    ];
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Sugar Centers',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Text(
              'Add to List',
              style: Styles.bold19,
            ),
          ),
          CustomDivider(),
          10.height,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => SugarCenterItemWidget(
                  sugarCenter: sugarCenters[index],
                  addToList: true,
                ),
                itemCount: sugarCenters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
