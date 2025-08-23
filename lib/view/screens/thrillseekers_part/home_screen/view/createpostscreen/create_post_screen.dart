/*
import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/view/components/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_test_field/custom_text_field.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppbar(
            title: "Create a Post",
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green_06,
                    border: Border.all(color: AppColors.green_07),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImage(imageSrc: AppIcons.upload),
                      CustomText(
                        text: 'Upload a photo or video',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.grey_15,
                        top: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomText(
                  text: 'Caption',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green_06,
                    border: Border.all(color: AppColors.green_07),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      fillColor: AppColors.green_06,
                      maxLines: 6,
                      color: AppColors.grey_15,
                      prefixIconLeftPadding: 0,
                      isPrefixIcon: false,
                      prefixIconRightPadding: 0,
                      hintPadding: EdgeInsets.only(left: 0),
                      // fieldBorderColor: AppColors.green_07,
                      hintText: 'write a caption',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomText(
                  text: 'Tag People (Optimal)',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 4),
                Wrap(
                  spacing: 8, // horizontal space between items
                  runSpacing: 8, // vertical space between rows
                  children: List.generate(4, (index) {   // try with more than 3 to test wrap
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // keeps container only as wide as content
                        children: [
                          CustomText(
                            text: 'Jane Cooper',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.clear),
                          ),
                        ],
                      ),
                    );
                  }),
                ),


                SizedBox(height: 16),
                //enter name
                Stack(
                  children: [
                    CustomTextField(
                      hintText: 'Enter a name',
                      color: AppColors.grey_15,
                      hintPadding: EdgeInsets.only(left: 15),
                      fieldBorderColor: AppColors.green_07,
                      fieldBorderRadius: 15,
                      fillColor: AppColors.green_06,
                    ),
                    Positioned(
                      top:0,
                      right: 0,
                      child: GestureDetector(
                        onTap: ()
                        {

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.green_01,
                            border: Border.all(color: AppColors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CustomText(
                            text: 'Add',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.socialScreen);
                  },
                  title: 'Post',
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
