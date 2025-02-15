import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/build_app_bar.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class AddArticleView extends StatelessWidget {
  const AddArticleView({super.key});
  static const routeName = 'addArticleView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Add Article', showProfile: false),
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
                      Text(
                        'Add Img',
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
                style:
                    Styles.regular13.copyWith(color: AppColor.lightGrayColor),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                hintText: 'e.g. Health Tips',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style:
                    Styles.regular13.copyWith(color: AppColor.lightGrayColor),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextFormField(
                maxLines: 6,
                hintText: 'e.g. The best way to lose weight is to eat less...',
                keyboardType: TextInputType.text,
                onSaved: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Add',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
