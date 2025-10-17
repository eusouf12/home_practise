import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../controller/auth_controller.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  final SignUpAuthModel? userModel = Get.arguments as SignUpAuthModel?;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomText(
                top: 20.h,
                text: AppStrings.forgetPassword,
                fontSize: 32.w,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: AppStrings.forgotTitle,
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black_02,
                maxLines: 3,
              ),
              SizedBox(
                height: 50,
              ),
              CustomFormCard(
                title: AppStrings.email,
                hintText: AppStrings.enterYourEmail,
                maxLine: 1,
                controller: authController.forgetPasswordController.value,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20.0),

          child:  Obx(() {
            return authController.otpLoading.value
                ? CustomLoader()
                : CustomButton(
              title: AppStrings.resetPassword,
              onTap: () {
                if (authController.forgetPasswordController.value.text.isEmpty) {
                  showCustomSnackBar("Email cannot be empty", isError: true);
                  return;
                }
                authController.forgetPassword(
                  screenName: userModel?.screenName ??"",
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
