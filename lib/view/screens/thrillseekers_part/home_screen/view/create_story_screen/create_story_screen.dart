/*
import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_test_field/custom_text_field.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: BackButton(color: AppColors.black),
                  ),
                  title: CustomText(
                    text: "Create a Story",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green_06,
                    border: Border.all(
                      color: AppColors.green_07,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImage(imageSrc: AppImages.upload),
                      CustomText(
                        text: 'Upload a photo or video',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.black_06,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomText(text: 'Add a Message', fontSize: 16),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green_06,
                    border: Border.all(
                      color: AppColors.green_07,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(fillColor: AppColors.green_06, hintText: "what's on your mind",),
                  ),
                ),
                SizedBox(height: 10),
                CustomButton(
                  onTap: () {
                    // Get.toNamed(AppRoutes.postStory);
                  },
                  title: 'Post to Story',
                  fontSize: 16,
                  fillColor: AppColors.green_01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
