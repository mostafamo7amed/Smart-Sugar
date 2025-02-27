import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import '../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  static const routeName = 'forgetPasswordView';

  @override
  State<ForgetPasswordView> createState() => _LoginViewState();
}

class _LoginViewState extends State<ForgetPasswordView> {
  String? email;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginResetPasswordSuccess) {
          getSnackBar('Check your email');
        }
      },
      builder: (context, state) {
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
                        'Reset Password',
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
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Reset Password',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<LoginCubit>().resetPassword(email!);
                          }
                        },
                      ),
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
