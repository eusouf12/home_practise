import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_from_card/custom_from_card.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_text_field/custom_text_field.dart';
import 'package:event_platform/view/screens/thrillseekers_part/favorite/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../host_part/social/controller/social_controller.dart';

class UploadScreen extends StatelessWidget {
   UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavouriteController controller = Get.find<FavouriteController>();
    final String eventId = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetPostFields();
    });

    return CustomGradient(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomRoyelAppbar(leftIcon: true, titleName: AppStrings.createPost),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.photo, color: AppColors.primary),
                                        title: const Text("Upload Photo"),
                                        onTap: () {
                                          controller.pickImage();
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.video_library, color: AppColors.primary),
                                        title: const Text("Upload Video"),
                                        onTap: () {
                                          controller.pickVideo();
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Obx(() {
                              final image = controller.selectedImage.value;
                              final videoThumb = controller.videoThumbnail.value;

                              return Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff96C9B8)),
                                  borderRadius: BorderRadius.circular(15),
                                  image: image != null
                                      ? DecorationImage(
                                    image: FileImage(image),
                                    fit: BoxFit.cover,
                                  )
                                      : videoThumb != null
                                      ? DecorationImage(
                                    image: FileImage(videoThumb),
                                    fit: BoxFit.cover,
                                  )
                                      : null,
                                ),
                                child: () {
                                  if (image != null || videoThumb != null) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if (videoThumb != null)
                                          const Icon(
                                            Icons.play_circle_fill,
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                      ],
                                    );
                                  } else {
                                    return const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.upload_file,
                                            size: 50, color: Color(0xff96C9B8)),
                                        CustomText(
                                          top: 10,
                                          text: AppStrings.uploadAPhotoOrVideo,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    );
                                  }
                                }(),
                              );
                            }),
                          ),

                          SizedBox(height: 20.h),
                          CustomFormCard(
                              title: AppStrings.caption,
                              hintText: AppStrings.writeCaption,
                              maxLine: 4,
                              controller: controller.contentController),
                          //Content Type
                          // CustomFormCard(
                          //     title: AppStrings.description,
                          //     hintText: "Write description (optional)",
                          //     maxLine: 1,
                          //     controller: controller.descriptionController),
                          Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Obx(() => controller.isPostingFavoriteContent.value
                              ? const CustomLoader()
                              : CustomButton(
                            onTap: () {
                              controller.createFavoritePost(eventId);
                            },
                            title: AppStrings.post,
                            fillColor: AppColors.primary,
                          )),
                          SizedBox(height: 20.h),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}