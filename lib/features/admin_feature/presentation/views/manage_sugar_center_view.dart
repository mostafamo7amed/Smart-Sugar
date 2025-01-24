import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/delete_sugar_center_view.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../centers/domain/entities/sugar_center_entity.dart';
import '../../../centers/presentation/views/widgets/sugar_center_item_widget.dart';
import 'widgets/add_sugar_center_view.dart';

class ManageSugarCenterView extends StatelessWidget {
  ManageSugarCenterView({super.key});
  static const routeName = 'ManageSugarCenterView';
  final List<SugarCenterEntity> sugarCenters = [
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
    SugarCenterEntity(
      name: 'International Medical Center (IMC)',
      id: '1',
      district: 'Al-Rawdah District',
      image:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNeJG67ejYXQF6k5Xm9uj3YpwLCd6HVGdBBw&s',
      phoneNumber: '+05012345678',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,
          title: 'Manage Sugar Centers', showProfile: false),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          child: Icon(
            size: 30,
            Icons.add,
            color: AppColor.whiteColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddSugarCenterView.routeName);
          },
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
              Navigator.pushNamed(context, DeleteSugarCenterView.routeName,
                  arguments: sugarCenters[index]);
            },
            child: SugarCenterItemWidget(
              sugarCenter: sugarCenters[index],
            ),
          ),
          itemCount: sugarCenters.length,
        ),
      ),
    );
  }
}
