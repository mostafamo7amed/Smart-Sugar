import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_divider.dart';
import 'package:smart_sugar/features/centers/domain/entities/sugar_center_entity.dart';
import 'package:smart_sugar/features/centers/presentation/views/add_to_list_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/district_item_widget.dart';

import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class ChooseDistrictView extends StatefulWidget {
  const ChooseDistrictView({super.key});
  static const routeName = 'ChooseDistrictView';

  @override
  State<ChooseDistrictView> createState() => _ChooseDistrictViewState();
}

class _ChooseDistrictViewState extends State<ChooseDistrictView> {
  int groupValue = -1;
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
              'Choose your district',
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                       groupValue = index;
                    });
                    Navigator.pushNamed(context, AddToListView.routeName);
                  },
                    child: DistrictItemWidget(
                  districtName: sugarCenters[index].district,
                  value: index,
                  groupValue: groupValue,
                )),
                itemCount: sugarCenters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
