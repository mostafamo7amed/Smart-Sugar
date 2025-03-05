import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';

import '../../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/build_app_bar.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../manager/admin_cubit.dart';

class AddArticleView extends StatelessWidget {
  AddArticleView({super.key});

  static const routeName = 'addArticleView';

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AddArticleSuccessState) {
          getSnackBar('Article Added Successfully');
          AdminCubit.get(context).getAllArticles();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is AddArticleLoadingState,
          child: Scaffold(
            appBar:
                buildAppBar(context, title: 'Add Article', showProfile: false),
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
                        'Title',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        controller: titleController,
                        hintText: 'e.g. Health Tips',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                        controller: descriptionController,
                        maxLines: 6,
                        hintText:
                            'e.g. The best way to lose weight is to eat less...',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
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
                              cubit.addArticle(
                                  titleController.text,
                                  descriptionController.text,
                                  cubit.pikedImage!);
                            } else {
                              getSnackBar('Please Select Image');
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
