import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../controller/auth_controller.dart';


class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  final SignUpAuthModel userModel = Get.arguments as SignUpAuthModel;

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CustomText(
                      top: 20,
                      text: "OTP Verification",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text:
                      "Please check your email to see the verification code",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_02,
                      maxLines: 4,
                    ),
                    SizedBox(height: 50.h,),
                    CustomText(
                      top: 20,
                      text: "OTP Code",
                      fontSize: 16,
                      bottom: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    /// Pin Code
                    CustomPinCode(controller: authController.otpController.value),
                    SizedBox(height: 20.h),
                    /// Submit Button
                    Obx(() {
                      return authController.otpLoading.value
                          ? CustomLoader()
                          : CustomButton(
                        title: AppStrings.submit,
                        onTap: () {
                          if (authController.otpController.value.text.isEmpty) {
                            showCustomSnackBar(
                              AppStrings.fieldCantBeEmpty,
                              isError: true,
                            );
                            return;
                          }
                          authController.verifyOtp(
                            screenName: userModel.screenName,
                          );
                        },
                      );
                    }),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

