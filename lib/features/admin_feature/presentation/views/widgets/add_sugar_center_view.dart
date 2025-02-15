import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/choose_center_location_view.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class AddSugarCenterView extends StatefulWidget {
  const AddSugarCenterView({super.key});
  static const routeName = 'addSugarCenterView';

  @override
  State<AddSugarCenterView> createState() => _AddSugarCenterViewState();
}


class _AddSugarCenterViewState extends State<AddSugarCenterView> {

  LatLng ? location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Add Sugar Center',showProfile: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                 // cubit.pickImage();
                },
                child: DottedBorder(
                  padding: const EdgeInsets.all(15),
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: AppColor.lightGrayColor,
                  dashPattern: const [3, 3],
                  strokeWidth: 1.5,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*if (cubit.taskImage == null)
                          Image.asset(
                            AssetsData.imageIcon,
                            width: 24,
                            height: 24,
                            color: AppColor.darkBlueColor,
                          ),
                        if (cubit.taskImage == null)
                          const SizedBox(
                            width: 5,
                          ),
                        cubit.taskImage != null
                            ? widget.editedTask != null
                            ? Text(
                          cubit.taskImage!.path.split('-').last,
                          style: Styles.textStyle16.copyWith(
                              color: AppColor.darkBlueColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                            : Text(
                          cubit.taskImage!.path.split('/').last,
                          style: Styles.regular16.copyWith(
                              color: AppColor.lightGrayColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                            : */Text(
                          'Add Img',
                          style: Styles.regular16.copyWith(
                              color: AppColor.lightGrayColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text('Name',style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),),
              const SizedBox(height: 5,),
              CustomTextFormField(
                hintText: 'e.g. Sugar Center',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
              ),
              const SizedBox(height: 10,),
              Text('Phone',style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),),
              const SizedBox(height: 5,),
              CustomTextFormField(
                hintText: 'e.g. +966 11 12345678',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
              ),
              const SizedBox(height: 10,),
              Text('Choose Location',style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),),
              const SizedBox(height: 5,),
              CustomTextFormField(
                hintText: 'e.g. 123, Street, City',
                readOnly: true,
                controller: TextEditingController(text: location == null ? '' : '${location!.latitude}, ${location!.longitude}'),
                keyboardType: TextInputType.text,
                onTap: () async {
                  final result = await Navigator.pushNamed(context, ChooseCenterLocationView.routeName);
                 log(result.toString());

                  if (result != null) {
                     setState(() {
                      location = result as LatLng;
                      log(location.toString());
                     });
                  }
                },
                onSaved: (value) {},
              ),
              SizedBox(height: 20,),
              CustomButton(
                text: 'Add',
                onPressed: () {

              },)


            ],
          ),
        ),
      ),
    );
  }
}
