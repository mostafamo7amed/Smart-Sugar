import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';
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
  LatLng? location;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AddSugarCenterSuccessState) {
          getSnackBar('Sugar Center Added Successfully');
          AdminCubit.get(context).getAllSugarCenter();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is AddSugarCenterLoadingState,
          child: Scaffold(
            appBar: buildAppBar(context,
                title: 'Add Sugar Center', showProfile: false),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.getImageFromGallery();
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
                              Text(
                                cubit.pikedImage != null
                                    ? cubit.pikedImage!.path.split('/').last
                                    : 'Add Img',
                                style: Styles.regular16
                                    .copyWith(color: AppColor.lightGrayColor),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        hintText: 'e.g. Sugar Center',
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Phone',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        controller: phoneController,
                        hintText: 'e.g. +966 11 12345678',
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Please Enter Phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Choose Location',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        hintText: 'e.g. 123, Street, City',
                        readOnly: true,
                        controller: TextEditingController(
                            text: location == null
                                ? ''
                                : '${location!.latitude}/${location!.longitude}'),
                        keyboardType: TextInputType.text,
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                              context, ChooseCenterLocationView.routeName);
                          log(result.toString());

                          if (result != null) {
                            setState(() {
                              location = result as LatLng;
                              log(location.toString());
                            });
                          }
                        },
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Please Choose Location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Add',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (cubit.pikedImage != null) {
                              cubit.addSugarCenter(
                                cubit.pikedImage!,
                                nameController.text,
                                phoneController.text,
                                location!.latitude.toString(),
                                location!.longitude.toString(),
                              );
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
