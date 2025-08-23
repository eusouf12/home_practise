import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Column(
                 children: [
                   CustomText(
                     top: 20.h,
                     text: AppStrings.welcomeBack,
                     fontSize: 32.w,
                     fontWeight: FontWeight.w600,
                   ),
                   CustomText(
                     text: AppStrings.welcomeBackTitle,
                     fontSize: 14.w,
                     fontWeight: FontWeight.w500,
                     color: AppColors.black_02,
                   ),
                 ],
               ),
               // SizedBox(height: 50.h),
                Column(
                  children: [
                    CustomFormCard(
                      title: AppStrings.email,
                      hintText: AppStrings.enterYourEmail,
                      controller: TextEditingController(),
                    ),
                    CustomFormCard(
                      title: AppStrings.password,
                      hintText: AppStrings.enterYourPassword,
                      isPassword: true,
                      controller: TextEditingController(),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.forgotScreen);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          text: AppStrings.forgetPassword,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w400,
                          bottom: 20.h,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: "Or",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w600,
                ),
                CustomButton(
                  showSocialButton: true,
                  onTap: () {},
                  imageSrc: AppIcons.google,
                  title: AppStrings.signInWithGoogle,
                  fillColor: AppColors.white,
                  textColor: AppColors.black,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                ),
               Column(
                 children: [
                   CustomButton(
                     onTap: () {
                        Get.offAllNamed(AppRoutes.chooseRoleScreen);
                     },
                     title: AppStrings.login,
                   ),
                   SizedBox(height: 10.h),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CustomText(
                         text: AppStrings.dontHaveAccount,
                         fontSize: 16.w,
                         fontWeight: FontWeight.w400,
                         color: AppColors.black_02,
                       ),
                       GestureDetector(
                         onTap: (){
                           Get.offAllNamed(AppRoutes.signUpScreen);
                         },
                         child: CustomText(
                           text: AppStrings.signUp,
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
          ),
        ],
      ),
    );
  }
}
