import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/build_app_bar.dart';
import '../../../../../core/utils/widgets/custom_button.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class AddEmergencyNumberView extends StatelessWidget {
  const AddEmergencyNumberView({super.key});
  static const routeName = 'add-emergency-number';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Add Number',showProfile: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text('Name',style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),),
              const SizedBox(height: 5,),
              CustomTextFormField(
                keyboardType: TextInputType.text,
                onSaved: (value) {},
              ),
              const SizedBox(height: 10,),
              Text('Phone',style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),),
              const SizedBox(height: 5,),
              CustomTextFormField(
                keyboardType: TextInputType.text,
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
