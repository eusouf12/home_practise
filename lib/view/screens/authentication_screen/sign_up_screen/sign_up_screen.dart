import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_loader/custom_loader.dart';
import 'package:event_platform/view/screens/authentication_screen/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_text/custom_text.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.createYourAccount,
                  fontSize: 20.w,
                  fontWeight: FontWeight.w600,
                  bottom: 40.h,
                ),
                Form(
                  key: formKey,
                  child: Obx(() {
                    return Column(
                      children: [
                        CustomFormCard(
                          title: AppStrings.name,
                          hintText: AppStrings.enterAName,
                          maxLine: 1,
                          controller: authController.nameController.value,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? AppStrings.enterName
                              : null,
                        ),
                        CustomFormCard(
                          title: AppStrings.email,
                          hintText: AppStrings.exampleEmail,
                          maxLine: 1,
                          controller: authController.emailController.value,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? AppStrings.enterYourEmail
                              : null,
                        ),
                        CustomFormCard(
                          title: AppStrings.phoneNumber,
                          maxLine: 1,
                          hintText: "+62 654567890",
                          controller: authController.phoneNumberController.value,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? AppStrings.phoneNumber
                              : null,
                        ),
                        CustomFormCard(
                          readOnly: true,
                          onTap: () => authController.pickDate(context),
                          title: AppStrings.dateOfBirthday,
                          maxLine: 1,
                          hintText: "Select date",
                          suffixIcon: Icon(Icons.calendar_today,
                              color: AppColors.primary),
                          controller:
                          authController.dateOfBirthController.value,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? AppStrings.typeYourDate
                              : null,
                        ),
                        CustomFormCard(
                          title: AppStrings.password,
                          hintText: AppStrings.passwordHint,
                          isPassword: true,
                          maxLine: 1,
                          controller: authController.passwordController.value,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? AppStrings.enterYourPassword
                              : null,
                        ),
                        CustomFormCard(
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.passwordHint,
                          isPassword: true,
                          maxLine: 1,
                          controller:
                          authController.confirmPasswordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.confirmPassword;
                            } else if (value !=
                                authController.passwordController.value.text) {
                              return AppStrings.passwordNotMatch;
                            }
                            return null;
                          },
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: 30.h),
                Obx(() {
                  return authController.signUpLoading.value
                      ? CustomLoader()
                      : CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        authController.signUp();
                      }
                    },
                    title: AppStrings.signUp,
                  );
                }),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppStrings.alreadyHaveAccount,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_02,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.loginScreen),
                      child: CustomText(
                        text: AppStrings.login,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
