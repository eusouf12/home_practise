import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
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

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({super.key});

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
              CustomRoyelAppbar(leftIcon: true, titleName: "Set New Password",),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CustomText(
                      top: 20.h,
                      text: "Set a new password",
                      fontSize: 32.w,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: 'Creat a new password. Ensure it differs from previous ones for security',
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_02,
                      maxLines: 3,
                    ),
                    SizedBox(height: 50,),
                    CustomFormCard(
                      title: "New Password",
                      hintText: AppStrings.enterYourPassword,
                      controller: TextEditingController(),
                    ),
                    CustomFormCard(
                      title: "Re-enter password",
                      hintText: AppStrings.enterYourEmail,
                      controller: TextEditingController(),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20.0),
        child: CustomButton(
          onTap: () {
            Get.offAllNamed(AppRoutes.loginScreen);
          },
          title: "Update Password",
        ),
      ),
    );
  }
}
