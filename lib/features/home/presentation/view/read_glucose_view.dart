import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/cached_image.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';

import '../../../../core/helper_functions/pike_date.dart';
import '../../../../core/helper_functions/pike_time.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';

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
                  CustomTextFormField(
                    controller: TextEditingController(text: dateText),
                    hintText: 'Date',
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? date = await pickDate(context);
                      if (date != null) {
                        dateText = DateFormat('yyyy/MM/dd').format(date);
                        setState(() {});
                      }
                    },
                    onSaved: (value) {
                      dateText = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: TextEditingController(text: timeText),
                    hintText: 'Time',
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? formattedPickedTime = await pickTime(context);
                      if (formattedPickedTime != null) {
                        timeText =
                            DateFormat('hh:mm a').format(formattedPickedTime);
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * .5,
                    height: 40,
                    color: AppColor.redColor.withValues(alpha: .5),
                    onPressed: () {},
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
