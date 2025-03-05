import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/features/centers/domain/entities/sugar_center_entity.dart';
import 'package:smart_sugar/features/centers/presentation/views/my_list_sugar_centers_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/sugar_details_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/sugar_center_item_widget.dart';

import '../../../../core/utils/app_manager/app_colors.dart';

class SugarCentersView extends StatelessWidget {
  const SugarCentersView({super.key});

  @override
  Widget build(BuildContext context) {
    List<SugarCenterEntity> sugarCenters = [
      SugarCenterEntity(
        name: 'International Medical Center (IMC)',
        id: '1',
        district: 'Al-Murjan District',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blueColor,
        onPressed: () {
          Navigator.pushNamed(context, MyListSugarCentersView.routeName);
        },
        child: Text(
          'My List',
          style: Styles.semiBold13.copyWith(color: AppColor.whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              log('click all sugar centers');
              Navigator.pushNamed(context, SugarDetailsView.routeName,
                  arguments: sugarCenters[index]);
            },
            child: SugarCenterItemWidget(

            ),
          ),
          itemCount: sugarCenters.length,
        ),
      ),
    );
  }
}
