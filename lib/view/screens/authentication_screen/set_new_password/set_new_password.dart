import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_text/custom_text.dart';
import '../controller/auth_controller.dart';

class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return CustomGradient(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            children: [
              CustomText(
                top: 20.h,
                text: "Set a new password",
                fontSize: 32.w,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text:
                    'Create a new password. Ensure it differs from previous ones for security',
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black_02,
                maxLines: 3,
              ),
              SizedBox(
                height: 50,
              ),
              CustomFormCard(
                title: "New Password",
                hintText: AppStrings.enterYourPassword,
                maxLine: 1,
                controller: authController.updatePasswordController.value,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20.0),
          child: CustomButton(
            onTap: () {
              if (authController.updatePasswordController.value.text.isEmpty) {
                showCustomSnackBar(
                  AppStrings.fieldCantBeEmpty,
                  isError: true,
                );
                return;
              }
              authController.updatePassword();
            },
            title: "Update Password",
          ),
        ),
      ),
    );
  }
}
