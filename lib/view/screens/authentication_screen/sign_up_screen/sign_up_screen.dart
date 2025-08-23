import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomRoyelAppbar(leftIcon: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: AppStrings.createYourAccount,
                      fontSize: 20.w,
                      fontWeight: FontWeight.w600,
                      bottom: 40.h,
                    ),
                    // SizedBox(height: 50.h),
                    Column(
                      children: [
                        CustomFormCard(
                          title: AppStrings.email,
                          hintText: AppStrings.exampleEmail,
                          controller: TextEditingController(),
                        ),
                        CustomFormCard(
                          title: AppStrings.password,
                          hintText: AppStrings.passwordHint,
                          isPassword: true,
                          controller: TextEditingController(),
                        ),
                        CustomFormCard(
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.passwordHint,
                          isPassword: true,
                          controller: TextEditingController(),
                        ),
                        Row(
                          children: [
                            Radio(
                                value: true,
                                groupValue: (true),
                                focusColor: AppColors.primary,
                                activeColor: AppColors.primary,
                                onChanged: (value) {}),
                            CustomText(
                              text: "I understand the",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text: "Terms & ",
                              fontSize: 16.w,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomText(
                              text: "Policy",
                              fontSize: 16.w,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 160.h),
                    Column(
                      children: [
                        CustomButton(
                          onTap: () {
                             Get.offAllNamed(AppRoutes.loginScreen);
                          },
                          title: AppStrings.signUp,
                        ),
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
                              onTap: (){
                                Get.toNamed(AppRoutes.loginScreen);
                              },
                              child: CustomText(
                                text: AppStrings.login,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
