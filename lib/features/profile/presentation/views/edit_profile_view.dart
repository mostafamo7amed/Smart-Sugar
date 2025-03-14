import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/custom_edit_item.dart';

import '../../../../constants.dart';
import '../../../../core/helper_functions/pike_date.dart';
import '../../../../core/services/app_references.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/cached_image.dart';
import '../../../../core/utils/widgets/custom_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  static const routeName = 'editProfileView';

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController heightUnitController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEdit = false;

  @override
  void initState() {
    fullNameController.text = UserCubit.get(context).userEntity?.name ?? '';
    emailController.text = UserCubit.get(context).userEntity?.email ?? '';
    ageController.text = UserCubit.get(context).userEntity?.dateOfBirth ?? '';
    weightController.text = UserCubit.get(context).userEntity?.weight ?? '';
    heightController.text = UserCubit.get(context).userEntity?.height ?? '';
    genderController.text = UserCubit.get(context).userEntity?.gender ?? '';
    heightUnitController.text = UserCubit.get(context).userEntity?.height ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Edit Profile',
        isProfile: true,
        showProfile: false,
        onProfileEdit: () {
          isEdit = !isEdit;
          setState(() {});
        },
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is EditUserProfileSuccessState) {
            UserCubit.get(context)
                .getUser(AppReference.getData(key: userIdKey));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return CustomProgressHud(
            isLoading: state is EditUserProfileLoadingState,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: size.height * .06, bottom: size.height * .03),
                      margin: EdgeInsets.only(top: size.height * .1),
                      width: size.width,
                      // height: size.height,
                      decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Personal Information', style: Styles.bold16),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomEditItem(
                              isEnabled: isEdit,
                              controller: fullNameController,
                              validation: (v) {
                                if (fullNameController.text.isEmpty) {
                                  return 'please enter your full name';
                                }
                                return null;
                              },
                              title: 'Name',
                              prefixWidget: SvgPicture.asset(
                                AssetsData.personIcon,
                                fit: BoxFit.scaleDown,
                                colorFilter: ColorFilter.mode(
                                    AppColor.pinkColor, BlendMode.srcIn),
                              ),
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomEditItem(
                              isEnabled: false,
                              controller: emailController,
                              validation: (v) {
                                if (emailController.text.isEmpty) {
                                  return 'please enter your email';
                                }
                                return null;
                              },
                              title: 'Email',
                              prefixWidget: Icon(
                                Icons.email_outlined,
                                color: AppColor.pinkColor,
                                size: 28,
                              ),
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomEditItem(
                              readOnly: true,
                              isEnabled: isEdit,
                              controller: ageController,
                              onTap: () async {
                                DateTime? date = await pickDate(context);
                                if (date != null) {
                                  ageController.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                  setState(() {});
                                }
                              },
                              validation: (v) {
                                if (ageController.text.isEmpty) {
                                  return 'please enter your age';
                                }
                                return null;
                              },
                              title: 'Age',
                              prefixWidget: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: SvgPicture.asset(
                                    AssetsData.ageIcon,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              textInputType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomEditItem(
                              isEnabled: false,
                              controller: genderController,
                              title: 'Gender',
                              prefixWidget: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    AssetsData.personIcon,
                                    fit: BoxFit.scaleDown,
                                    colorFilter: ColorFilter.mode(
                                        AppColor.pinkColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomEditItem(
                              isEnabled: isEdit,
                              controller: weightController,
                              validation: (v) {
                                if (weightController.text.isEmpty) {
                                  return "please enter your weight";
                                } else if (double.parse(weightController.text) >
                                    300) {
                                  return "please enter valid weight";
                                }
                                return null;
                              },
                              title: 'Weight',
                              prefixWidget: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    AssetsData.weightIcon,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              suffixIc: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'kg',
                                  style: Styles.regular16
                                      .copyWith(color: AppColor.lightGrayColor),
                                ),
                              ),
                              textInputType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomEditItem(
                              isEnabled: isEdit,
                              controller: heightController,
                              validation: (v) {
                                if (heightController.text.isEmpty) {
                                  return "please enter your height";
                                } else if (double.parse(heightController.text) >
                                    300) {
                                  return "please enter valid height";
                                }
                                return null;
                              },
                              title: 'Height',
                              prefixWidget: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    AssetsData.weightIcon,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              suffixIc: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'cm',
                                  style: Styles.regular16
                                      .copyWith(color: AppColor.lightGrayColor),
                                ),
                              ),
                              textInputType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Sugar Information', style: Styles.bold16),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Diabetes Type',
                              style: Styles.regular13
                                  .copyWith(color: AppColor.lightGrayColor),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.fillColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  cubit.userEntity?.diabetesType ?? '',
                                  style: Styles.regular16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Therapy Type',
                              style: Styles.regular13
                                  .copyWith(color: AppColor.lightGrayColor),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.fillColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  cubit.userEntity?.therapyType ?? '',
                                  style: Styles.regular16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: isEdit,
                              child: CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    cubit.editUserProfile(
                                        cubit.userEntity!.uid!,
                                        fullNameController.text,
                                        heightController.text,
                                        weightController.text,
                                        cubit.pikedImage,
                                        ageController.text);
                                  }
                                },
                                text: 'Save Changes',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: size.width,
                    top: size.height * .03,
                    child: Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.fillColor,
                            radius: 50,
                            child: cubit.pikedImage != null
                                ? Image.file(
                                    cubit.pikedImage!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).cornerRadiusWithClipRRect(50)
                                : cubit.userEntity?.image != ''
                                    ? cachedImage(
                                        cubit.userEntity!.image,
                                        AssetsData.placeHolder,
                                        height: 100,
                                        width: 100,
                                      ).cornerRadiusWithClipRRect(50)
                                    : SvgPicture.asset(
                                        AssetsData.profileIcon,
                                        fit: BoxFit.scaleDown,
                                        colorFilter: ColorFilter.mode(
                                            AppColor.pinkColor,
                                            BlendMode.srcIn),
                                      ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Visibility(
                              visible: isEdit,
                              child: GestureDetector(
                                onTap: () {
                                  cubit.getImageFromGallery();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.pinkColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      size: 20,
                                      Icons.camera_alt_outlined,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
