import 'package:event_platform/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_text/custom_text.dart';

class OtpScreeen extends StatelessWidget {
  const OtpScreeen({super.key});

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
              CustomRoyelAppbar(leftIcon: true, titleName: "OTP Verification",),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CustomText(
                      top: 20.h,
                      text: "OTP Verification",
                      fontSize: 32.w,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: "Please check your email arraiahn815@gmail.com to see the verification code",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_02,
                      maxLines: 4,
                    ),
                    SizedBox(height: 50,),
                    CustomText(
                      top: 20.h,
                      text: "OTP Code",
                      fontSize: 14.w,
                      bottom: 16.h,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomPinCode(controller: TextEditingController()),
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
            Get.offAllNamed(AppRoutes.setNewPassword);
          },
          title: "Verify Code",
        ),
      ),
    );
  }
}
