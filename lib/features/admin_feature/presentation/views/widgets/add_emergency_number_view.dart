import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';

import '../../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/build_app_bar.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class AddEmergencyNumberView extends StatelessWidget {
  AddEmergencyNumberView({super.key});

  static const routeName = 'add-emergency-number';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AddEmergencyNumberSuccessState) {
          getSnackBar('Emergency Number Added Successfully');
          AdminCubit.get(context).getAllEmergencyNumber();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is AddEmergencyNumberLoadingState,
          child: Scaffold(
            appBar:
                buildAppBar(context, title: 'Add Number', showProfile: false),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        hintText: 'e.g. emergency',
                        keyboardType: TextInputType.text,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'Required';
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
                            return 'Required';
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
                            cubit.addEmergencyNumber(
                              phoneController.text,
                              nameController.text,
                            );
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
