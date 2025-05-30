import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/auth/presentation/views/on_boarding_view.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_password_field.dart';

import '../../../../constants.dart';
import '../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../manager/register_cubit/register_cubit.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const routeName = 'registerView';

  @override
  State<RegisterView> createState() => _LoginViewState();
}

class _LoginViewState extends State<RegisterView> {
  String? name, email, password, confirmPassword;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppReference.sharedPreferences.setBool(authKey, true);
          AppReference.sharedPreferences.setString(userIdKey, state.user.uid);
          Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is RegisterLoading ? true : false,
          child: Scaffold(
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
                            width: 175,
                            height: 175,
                            child: Image.asset(AssetsData.appLogo),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Create Account',
                          style: Styles.bold19,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                            hintText: 'Name',
                            keyboardType: TextInputType.name,
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
                              name = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.email_outlined,
                                color: AppColor.pinkColor,
                                size: 28,
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
                        CustomPasswordFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter confirm password';
                            }
                            return null;
                          },
                          hintText: 'Confirm Password',
                          onSaved: (value) {
                            confirmPassword = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'Register',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              autoValidateMode = AutovalidateMode.disabled;
                              if (password == confirmPassword) {
                                context.read<RegisterCubit>().registerUser(
                                      email: email!,
                                      password: password!,
                                      name: name!,
                                    );
                              } else {
                                getSnackBar('Passwords do not match');
                                autoValidateMode = AutovalidateMode.always;
                              }
                            } else {
                              autoValidateMode = AutovalidateMode.always;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: Styles.regular13
                                .copyWith(color: AppColor.lightGrayColor),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      LoginView.routeName,
                                    );
                                  },
                                text: 'Login',
                                style: Styles.regular13
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                       /* Center(
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
                        )*/
                      ],
                    ),
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
