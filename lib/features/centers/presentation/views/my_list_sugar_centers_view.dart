import 'package:flutter/material.dart';
import 'package:smart_sugar/features/centers/presentation/views/sugar_details_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/sugar_center_item_widget.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../domain/entities/sugar_center_entity.dart';

class MyListSugarCentersView extends StatelessWidget {
  const MyListSugarCentersView({super.key});
  static const routeName = 'myListSugarCentersView';

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
      appBar:
      buildAppBar(context, title: 'My List', showBackButton: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SugarDetailsView.routeName,
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
