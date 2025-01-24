import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/custom_edit_item.dart';

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

  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  TextEditingController heightController = TextEditingController();

  List<String> gender = ['Male', 'Female'];

  String? selectedGender;

  final formKey = GlobalKey<FormState>();
  int groupValue = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context,
          title: 'Edit Profile', isProfile: true, showProfile: false),
      body: SingleChildScrollView(
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
                        controller: ageController,
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
                      Text(
                        'Gender',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      DropdownButtonFormField2<String>(
                        value: selectedGender,
                        isExpanded: true,
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            AssetsData.personIcon,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                AppColor.pinkColor, BlendMode.srcIn),
                          ),
                          fillColor: AppColor.fillColor,
                          hintStyle: Styles.regular16
                              .copyWith(color: AppColor.lightGrayColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.lightGrayColor, width: .5),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.lightGrayColor, width: .5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: gender
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: Styles.regular16
                                        .copyWith(color: AppColor.blackColor),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'please select your gender';
                          }
                          return null;
                        },
                        onMenuStateChange: (value) {
                          // cubit.changeGenderMenu();
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        },
                        onSaved: (value) {
                          selectedGender = value.toString();
                        },
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColor.lightGrayColor,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomEditItem(
                        controller: weightController,
                        validation: (v) {
                          if (weightController.text.isEmpty) {
                            return "please enter your weight";
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
                            'Type 1',
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
                            'Insulin',
                            style: Styles.regular16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                            'Pills',
                            style: Styles.regular16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: 'Save Changes',
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
                child: CircleAvatar(
                  backgroundColor: AppColor.fillColor,
                  radius: 50,
                  child: cachedImage(
                          AssetsData.chatGptIcon, AssetsData.placeHolder)
                      .cornerRadiusWithClipRRect(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
