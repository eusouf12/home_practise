import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_from_card/custom_from_card.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../controller/home_controller/dm_home_controller.dart';

class CreatePostLive extends StatelessWidget {
  CreatePostLive({super.key});
  final DmHomeController dmHomeController = Get.find<DmHomeController>();
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    final String? eventId = arguments['eventId'];
    debugPrint("Event  show ID: $eventId");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dmHomeController.resetCreatePostFields();
    });

    return CustomGradient(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomRoyelAppbar(leftIcon: true, titleName: "Create Post Live"),
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
                              dmHomeController.pickImage();
                            },
                            child: Obx(() {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color(0xff96C9B8)),
                                  borderRadius: BorderRadius.circular(15),
                                  image: dmHomeController.selectedImage.value != null
                                      ? DecorationImage(
                                    image: FileImage(
                                        dmHomeController.selectedImage.value!),
                                    fit: BoxFit.cover,
                                  )
                                      : null,
                                ),
                                child: dmHomeController.selectedImage.value == null
                                    ? const Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload_file,
                                        size: 50,
                                        color: Color(0xff96C9B8)),
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
                              );
                            }),
                          ),
                          SizedBox(height: 20.h),

                          CustomFormCard(
                              title: AppStrings.caption,
                              hintText: AppStrings.writeCaption,
                              maxLine: 4,
                              controller: dmHomeController.captionController),
                          CustomFormCard(
                              title: AppStrings.eventNameLocation,
                              hintText: AppStrings.eventNameLocationDes,
                              maxLine: 1,
                              controller: dmHomeController.locationNameController),
                          // Use controller

                          Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Tag People (Optional)",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Obx(() => Text(
                                      "${dmHomeController.taggedPeople.length}/220",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280)),
                                    )),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Obx(() => Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: dmHomeController.taggedPeople
                                      .map(
                                        (tag) => Chip(
                                      label: Text(tag),
                                      deleteIcon: const Icon(
                                          Icons.close,
                                          size: 18),
                                      onDeleted: () {
                                        dmHomeController.removeTag(
                                            tag); // Use controller
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: AppColors.primary),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                )),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomTextField(
                                          textEditingController:
                                          dmHomeController.tagController,
                                          // Use controller
                                          fillColor: Colors.transparent,
                                          fieldBorderColor: Colors.black26,
                                          inputTextStyle:
                                          const TextStyle(color: Colors.black),
                                          hintText: AppStrings.enterName,
                                          hintStyle: const TextStyle(
                                              color: AppColors.primary),
                                        )),
                                    const SizedBox(width: 4),
                                    ElevatedButton(
                                      onPressed: () {
                                        dmHomeController.addTag();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 20),
                                      ),
                                      child: const CustomText(
                                        text: "Add",
                                        fontSize: 16,
                                        color: AppColors.white_50,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),

                          Obx(() => dmHomeController.isCreatingPost.value
                              ? const CustomLoader()
                              : CustomButton(
                            onTap: () {
                              dmHomeController.createPost();
                            },
                            title: "Post",
                            fillColor: AppColors.primary,
                          ),
                          ),
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
