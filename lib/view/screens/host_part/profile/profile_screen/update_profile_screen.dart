import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/screens/host_part/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import 'dart:io';


class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});
  // final ProfileController profileController = Get.put(ProfileController());
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Fetch user profile when screen loads
    profileController.getUserProfile();

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Update Profile"),
        body: Obx(() {
          // Show loader while fetching profile
          if (profileController.rxRequestStatus.value == Status.loading) {
            return const Center(child: CustomLoader());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 138.h,
                          width: 138.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 4,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipOval(
                              child: profileController.selectedImage.value != null
                                  ? Image.file(
                                profileController.selectedImage.value!,
                                fit: BoxFit.cover,
                                height: 138.h,
                                width: 138.w,
                              )
                                  : (profileController.userProfileModel.value.photo.isNotEmpty
                                  ?  Image.network(ApiUrl.baseUrl + "/" + profileController.userProfileModel.value.photo,
                                fit: BoxFit.cover,
                                height: 141,
                                width: 141,
                              )
                                  : CustomNetworkImage(
                                imageUrl: AppConstants.profileImage,
                                height: 70.h,
                                width: 70.w,
                                boxShape: BoxShape.circle,
                              )),
                            ),
                          ),
                        ),
                      ),
                      // change img btn
                      Positioned(
                        right: 120.w,
                        bottom: 10.w,
                        child: GestureDetector(
                          onTap: () {
                            profileController.pickImageFromGallery();
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 4,
                              ),
                            ),
                            child: const Icon(Icons.edit, size: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name
                  Obx(() => CustomFormCard(
                    title: 'Name',
                    fontSize: 16,
                    hintText: 'Enter Your Name',
                    controller: profileController.nameController.value,
                  )),

                  // Email
                  Obx(() => CustomFormCard(
                    title: 'Email',
                    hintText: 'Enter Your Email',
                    controller: profileController.emailController.value,
                    readOnly: true,
                  )),

                  // Phone Number
                  Obx(() => CustomFormCard(
                    title: 'Number',
                    hintText: '+91 1234567890',
                    controller: profileController.phoneNumberController.value,
                  )),

                  // Date of Birth
                  Obx(() => CustomFormCard(
                    title: 'Date of Birth',
                    hintText: '10/10/2023',
                    controller: profileController.dateOfBirthController.value,
                  )),
                  const SizedBox(height: 31),

                  // Save button or loader
                  Obx(() => profileController.updateProfileLoading.value
                      ? const CustomLoader()
                      : CustomButton(
                    onTap: () {
                      profileController.updateProfile();
                    },
                    title: 'Save Changes',
                    fillColor: AppColors.primary,
                  )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
