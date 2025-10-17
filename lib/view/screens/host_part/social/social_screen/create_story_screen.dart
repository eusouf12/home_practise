import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/social_controller.dart';

class CreateStoryScreen extends StatelessWidget {
  CreateStoryScreen({super.key});

  final SocialController controller = Get.put(SocialController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetCreateStoryFields();
    });
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                CustomRoyelAppbar(leftIcon: true, titleName: "Create Story"),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Column(
                    children: [
                      // ==================== IMAGE PICKER ====================
                      Obx(() {
                        final isTextTyped =
                            controller.isTextTyped.value;

                        return GestureDetector(
                          onTap: isTextTyped
                              ? null // disable when text is typed
                              : () {
                            controller.pickImage();
                          },
                          child: Opacity(
                            opacity: isTextTyped ? 0.5 : 1.0,
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                Border.all(color: const Color(0xff96C9B8)),
                                borderRadius: BorderRadius.circular(15),
                                image: controller.selectedImage.value != null
                                    ? DecorationImage(
                                  image: FileImage(
                                      controller.selectedImage.value!),
                                  fit: BoxFit.cover,
                                )
                                    : null,
                              ),
                              child: controller.selectedImage.value == null
                                  ? const Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_file,
                                      size: 50, color: Color(0xff96C9B8)),
                                  CustomText(
                                    top: 10,
                                    text: 'Upload a photo or video',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ],
                              )
                                  : null,
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: 20.h),

                      // ==================== TEXT FIELD ====================
                      Obx(() {
                        final isImagePicked =
                            controller.selectedImage.value != null;

                        return CustomFormCard(
                          title: AppStrings.message,
                          //enabled: true,
                          hintText: AppStrings.whatOnYourMind,
                          maxLine: 4,

                          controller: controller.messageController,
                          enabled: !isImagePicked, // disable text when image is selected
                        );
                      }),

                      SizedBox(height: 20.h),

                      // ==================== BUTTON ====================
                      Obx(() => controller.isCreatingPost.value
                          ? const CustomLoader()
                          : CustomButton(
                        onTap: () {
                          if (controller.selectedImage.value == null &&
                              controller
                                  .messageController.text.isEmpty) {
                            Get.snackbar("Error",
                                "Please upload an image or write something.");
                          } else {
                            controller.createStory();
                          }
                        },
                        title: AppStrings.postToStory,
                        fillColor: AppColors.primary,
                      )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
