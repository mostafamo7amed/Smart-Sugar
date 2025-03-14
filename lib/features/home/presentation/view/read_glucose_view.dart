import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/cached_image.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/measurement_time_widget.dart';

import '../../../../constants.dart';
import '../../../../core/helper_functions/pike_date.dart';
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
  TextEditingController glucoseController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String measureTime = '';
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is EvaluateBloodSugarSuccessState) {
          showReadingResult(
            state.result,
            context,
          );
        }
        if (state is EvaluateBloodSugarErrorState) {
          getSnackBar(state.result);
        }
        if (state is AddGlucoseReadSuccessState) {
          glucoseController.text = '';
          dateController.text = '';
          UserCubit.get(context)
              .getSugarRead(AppReference.getData(key: userIdKey));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(context, title: 'Glucose'),
          body: CustomProgressHud(
            isLoading: state is EvaluateBloodSugarLoadingState ||
                state is AddGlucoseReadLoadingState,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                            controller: glucoseController,
                            hintText: 'Glucose',
                            keyboardType: TextInputType.number,
                            onSaved: (value) {},
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter glucose';
                              } else if (!isNumeric(p0)) {
                                return 'Please enter valid glucose';
                              } else if (int.parse(p0) > 250 ||
                                  int.parse(p0) <= 60) {
                                return 'Please enter valid glucose';
                              }
                              return null;
                            },
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
                              setState(() {
                                measureTime = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            readOnly: true,
                            controller: dateController,
                            hintText: 'Date',
                            keyboardType: TextInputType.number,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please enter date';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? date = await pickDate(context);
                              if (date != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(date);
                                setState(() {});
                                dateController.text = formattedDate;
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
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                cubit.evaluateBloodSugar(
                                    double.parse(glucoseController.text),
                                    measureTime);
                              }
                            },
                            text: 'Add Read',
                          ),
                        ],
                      ),
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

  void showReadingResult(String result, BuildContext context) {
    switch (result) {
      case 'Normal':
        customDialogSugarMeasurement(
          context: context,
          icon: Icon(
            size: 40,
            Icons.check,
            color: AppColor.primaryColor,
          ),
          result: result,
          message: 'The sugar level is normal ✅',
          color: AppColor.primaryColor,
          onConfirm: () {
            UserCubit.get(context).addGlucoseRead(
                int.parse(glucoseController.text),
                dateController.text,
                measureTime,
                result,
                AppReference.getData(key: userIdKey));
            Navigator.pop(context);
          },
        );
        break;
      case 'High':
        customDialogSugarMeasurement(
          context: context,
          icon: Icon(
            size: 40,
            Icons.warning_amber_rounded,
            color: AppColor.redColor,
          ),
          result: result,
          message: 'Warning! The sugar level is high, please monitor it.⚠️',
          color: AppColor.primaryColor,
          onConfirm: () {
            UserCubit.get(context).addGlucoseRead(
                int.parse(glucoseController.text),
                dateController.text,
                measureTime,
                result,
                AppReference.getData(key: userIdKey));
            Navigator.pop(context);
          },
        );
        break;
      case 'Low':
        customDialogSugarMeasurement(
          context: context,
          icon: Icon(
            size: 40,
            Icons.warning,
            color: AppColor.yellowColor,
          ),
          result: result,
          message: 'The sugar level is low, have a snack immediately.⚠️',
          color: AppColor.primaryColor,
          onConfirm: () {
            UserCubit.get(context).addGlucoseRead(
                int.parse(glucoseController.text),
                dateController.text,
                measureTime,
                result,
                AppReference.getData(key: userIdKey));
            Navigator.pop(context);
          },
        );
        break;
      case 'Very high':
        customDialogSugarMeasurement(
          context: context,
          icon: Icon(
            size: 40,
            Icons.dangerous,
            color: AppColor.redColor,
          ),
          result: result,
          message:
              'Danger! The sugar level is too high, immediately consult a doctor.🚨',
          color: AppColor.primaryColor,
          onConfirm: () {
            UserCubit.get(context).addGlucoseRead(
                int.parse(glucoseController.text),
                dateController.text,
                measureTime,
                result,
                AppReference.getData(key: userIdKey));
            Navigator.pop(context);
          },
        );
        break;
      case 'Invalid reading type':
        customDialogSugarMeasurement(
          context: context,
          icon: Icon(
            size: 40,
            Icons.close,
            color: AppColor.redColor,
          ),
          result: result,
          message: 'The reading type is invalid, please try again.',
          color: AppColor.primaryColor,
          onConfirm: () {
            Navigator.pop(context);
          },
        );
        break;
      default:
        break;
    }
  }

  bool isNumeric(String p0) {
    try {
      int.parse(p0);
      return true;
    } catch (e) {
      return false;
    }
  }
}
