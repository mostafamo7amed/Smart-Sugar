import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';

import '../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';

class RefreshApiView extends StatefulWidget {
  const RefreshApiView({super.key});
  static const routeName = 'refresh_api_view';

  @override
  State<RefreshApiView> createState() => _RefreshApiViewState();
}

class _RefreshApiViewState extends State<RefreshApiView> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController linkController = TextEditingController();
  @override
  initState() {
    AdminCubit.get(context).getApiLink();
    linkController.text = AdminCubit.get(context).apiLink!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is RefreshApiLinkSuccessState) {
          getSnackBar('Api Link Updated Successfully');
          AdminCubit.get(context).getApiLink();
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is RefreshApiLinkLoadingState ||
              state is GetApiLinkLoadingState,
          child: Scaffold(
            appBar:
                buildAppBar(context, title: 'Refresh API', showProfile: false),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You can refresh system API link from here',
                      style: Styles.semiBold13
                          .copyWith(color: AppColor.lightGrayColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: linkController,
                      hintText: 'Enter Api Link',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          AssetsData.infoImage,
                          colorFilter: ColorFilter.mode(
                              AppColor.pinkColor, BlendMode.srcIn),
                          width: 20,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Api Link';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          cubit.refreshApiLink(linkController.text);
                        }
                      },
                      text: 'Refresh',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
