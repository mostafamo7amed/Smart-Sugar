import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/auth/presentation/views/register_view.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_image_button.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_password_field.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import 'forget_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = 'loginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: autoValidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(AssetsData.appLogo),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Login',
                    style: Styles.bold19,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          AssetsData.personIcon,
                          colorFilter: ColorFilter.mode(
                              AppColor.pinkColor, BlendMode.srcIn),
                          width: 20,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      onSaved: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomPasswordFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordView.routeName
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: Styles.regular13
                            .copyWith(color: AppColor.lightGrayColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Styles.regular13
                          .copyWith(color: AppColor.lightGrayColor),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, RegisterView.routeName);
                            },
                          text: 'Register',
                          style: Styles.regular13
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Or',
                      style: Styles.semiBold13
                          .copyWith(color: AppColor.lightGrayColor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageButton(
                        onTap: () {},
                        imagePath: AssetsData.googleIcon,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      CustomImageButton(
                        onTap: () {},
                        imagePath: AssetsData.iPhoneIcon,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
