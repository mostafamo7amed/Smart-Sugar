import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/cached_image.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/measurement_time_widget.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/custom_dialog_sugar_measurement.dart';

class ReadGlucoseView extends StatefulWidget {
  const ReadGlucoseView({super.key});
  static const routeName = 'read-glucose';

  @override
  State<ReadGlucoseView> createState() => _ReadGlucoseViewState();
}

class _ReadGlucoseViewState extends State<ReadGlucoseView> {
  String? dateText;
  String? timeText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Glucose'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cachedImage(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .25,
                    fit: BoxFit.contain,
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy750iDJNVZJSwI5mrMXG69OBHDgDcImx5kg&s',
                    AssetsData.placeHolder,
                    usePlaceholderIfUrlEmpty: true)
                .cornerRadiusWithClipRRect(12),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'Glucose',
                    keyboardType: TextInputType.number,
                    onSaved: (value) {},
                    suffixIcon: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'mg/dl  ',
                        style: Styles.regular16.copyWith(
                          color: AppColor.lightGrayColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MeasurementTimeWidget(
                    onChanged: (value) {

                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * .5,
                    height: 40,
                    color: AppColor.redColor.withValues(alpha: .5),
                    onPressed: () {
                      customDialogSugarMeasurement(
                        context: context,
                       icon: Icon(
                         size: 40,
                         Icons.check,
                         color: AppColor.primaryColor,),
                       message: 'The sugar level is normal ✅',
                        color: AppColor.primaryColor,
                        onConfirm: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    text: 'Add Read',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
