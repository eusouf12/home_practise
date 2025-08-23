import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../../components/custom_text/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 147,
                      width: 147,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary, // Border color
                          width: 4, // Border width
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: CustomNetworkImage(
                           imageUrl: AppConstants.profileImage,
                           height: 70.h,
                           width: 70.w,
                           boxShape: BoxShape.circle,
                         ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Mehedi Bin Ab. Salam",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        bottom: 4.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppIcons.star),
                          CustomText(
                            left: 10,
                            text: "4.8 Host Rating",
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.updateProfileScreen);
                    },
                    child: CustomText(
                      text: 'Edit Profile',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.paymentSetupScreen);
                    },
                    child: CustomText(
                      text: 'Add Payment Method',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Get.toNamed(AppRoutes.editProfileScreen);
                    },
                    child: CustomText(
                      text: 'Push notifications',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.privacyPolicyScreen);
                    },
                    child: CustomText(
                      text: 'Privacy Policy',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.termsConditionScreen);
                    },
                    child: CustomText(
                      text: 'Terms  & Condition',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.languageScreen);
                    },
                    child: CustomText(
                      text: 'Language',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ), TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.changePasswordScreen);
                    },
                    child: CustomText(
                      text: 'Change Password',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                 /* TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.supportFeedbackScreen);
                    },
                    child: CustomText(
                      text: 'Support & Feedback',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),*/
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.hostFollowersScreen);
                    },
                    child: CustomText(
                      text: 'Followers',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => AlertDialog(
                          backgroundColor: AppColors.white,
                          insetPadding: EdgeInsets.all(8),
                          contentPadding: EdgeInsets.all(8),
                          content: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: CustomShowDialog(
                              textColor: AppColors.black,
                              title: "Logout Your Account",
                              discription: "Are you sure you want to Logout ?",
                              showColumnButton: true,
                              showCloseButton: true,
                              rightOnTap: () {
                                Get.back();
                              },
                              leftOnTap: () => Get.toNamed(AppRoutes.loginScreen),// Debugging
                            ),
                          ),
                        ),
                      );
                    },
                    child: CustomText(
                      text: 'Logout',
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HostNavbar(
              currentIndex: 4,
            ),
          )
        ],
      ),
      // bottomNavigationBar: HostNavbar(currentIndex: 0,),
    );
  }
}
