import 'package:event_platform/helper/image_handelar/image_handelar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../controller/dm_profile_controller.dart';

class DmProfileScreen extends StatelessWidget {
   DmProfileScreen({super.key});
   final DmProfileController dmProfileController = Get.put(DmProfileController());


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dmProfileController.getUserProfile();
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 60),
          child: SingleChildScrollView(
            child: Obx((){
              if (dmProfileController.rxRequestStatus.value == Status.loading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Center(child: CustomLoader()),
                );
              }

              if (dmProfileController.rxRequestStatus.value == Status.error) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child:   Center(child: Text("Failed to load profile")),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: Container(
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary, // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: ClipOval(
                              child: CustomNetworkImage(
                                imageUrl:dmProfileController.userProfileModel.value.photo != null?"${ApiUrl.baseUrl}/${dmProfileController.userProfileModel.value.photo}" : AppConstants.profileImage,
                                height: 70.h,
                                width: 70.w,
                                boxShape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: dmProfileController.userProfileModel.value.name?? "",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w600,
                            bottom: 4.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(imageSrc: AppIcons.star,height: 16.h,width: 16.w,),
                              CustomText(
                                left: 5,
                                text: "4.8 Host Rating",
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomText(
                    top: 10,
                    text: "Your Point 500",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w700,
                    bottom: 10.h,
                  ),
                  LinearProgressIndicator(
                    trackGap: 20,
                    value: 0.2, // Set to 0.2 for 20% progress
                    minHeight: 20.h,
                    backgroundColor: AppColors.greyLight,
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  CustomText(
                    top: 4,
                    text: "Get 3000 Point more to get verify",
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    bottom: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmEditProfileScreen);
                    },
                    child: CustomText(
                      text: 'Edit Profile',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmTicketScannerPage);
                    },
                    child: CustomText(
                      text: 'Tickets',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.ticketsHistory);
                    },
                    child: CustomText(
                      text: 'Ticket History',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //Event History
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.eventHistory);
                    },
                    child: CustomText(
                      text: 'Event History',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Get.toNamed(AppRoutes.privacyScreen);
                        },
                        child: CustomText(
                          text: 'Push notification',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Switch(
                          activeColor: AppColors.primary, value: true, onChanged: (value) {})
                    ],
                  ),

                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmPrivacyScreen);
                    },
                    child: CustomText(
                      text: 'Privacy Policy',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmTermsConditionScreen);
                    },
                    child: CustomText(
                      text: 'Terms & Condition',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmChangePasswordScreen);
                    },
                    child: CustomText(
                      text: 'Change Password',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  /* TextButton(
                  onPressed: () {
                    // Get.toNamed(AppRoutes.supportScreen);
                  },
                  child: CustomText(
                    text: 'Support & Feedback',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmFollowersScreen);
                    },
                    child: CustomText(
                      text: 'Followers',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  /*  TextButton(
                  onPressed: () {},
                  child: CustomText(
                    text: 'Delete Account',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
                  TextButton(
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
                              leftOnTap: () => Get.toNamed(AppRoutes.loginScreen),
                            ),
                          ),
                        ),
                      );
                    },
                    child: CustomText(
                      text: 'Logout',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green,
                    ),
                  ),
                ],
              );
            })

          ),
        ),
        bottomNavigationBar: DmNavBar(currentIndex: 4),
      ),
    );
  }
}
