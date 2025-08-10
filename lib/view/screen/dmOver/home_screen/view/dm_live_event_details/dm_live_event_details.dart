import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_test_field/custom_text_field.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmLiveEventDetails extends StatefulWidget {
  const DmLiveEventDetails({super.key});

  @override
  State<DmLiveEventDetails> createState() => _DmLiveEventDetailsState();
}

class _DmLiveEventDetailsState extends State<DmLiveEventDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: Container(
              height: 38.5.h,
              width: 38.5.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: BackButton(color: AppColors.black),
            ),
          ),


          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.r),
                          ),
                          child: CustomImage(
                            imageSrc: AppImages.card,
                            fit: BoxFit.cover,
                            height: 150.h,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: 'Live Jazz Night',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomText(text: 'Public Group'),
                                  SizedBox(width: 40),
                                  CustomImage(imageSrc: AppIcons.users),
                                  CustomText(text: 'Public Group'),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 43,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: AppColors.grey_02,
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomImage(
                                            imageSrc: AppIcons.join,
                                          ),
                                          SizedBox(width: 5),
                                          CustomText(
                                            text: 'Joined',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.dmLiveScreen);
                                    },
                                    child: Container(
                                      height: 43,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: AppColors.red_03,
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomImage(
                                            imageSrc: AppImages.object_2,
                                          ),
                                          SizedBox(width: 5),
                                          CustomText(
                                            text: 'Invite',
                                            color: AppColors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomButton(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.dmLiveScreen);
                                    },
                                    title: 'Venue Facility',
                                    fillColor: AppColors.grey_02,
                                    height: 43,
                                    width: 110,
                                    borderRadius: 30,
                                    fontSize: 12,
                                    textColor: AppColors.black,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30, // Adjust size
                                    backgroundImage: AssetImage(
                                      'assets/images/img.jpg',
                                    ),
                                  ),
                                  SizedBox(width: 20),

                                  // CustomFormCard(title: '', controller: TextEditingController()),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.dmLiveScreen);
                                      },
                                      child: CustomTextField(
                                        hintText: 'Write Something...',
                                        readOnly: true,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.dmHomeScreen);
                                    },
                                    child: CustomImage(
                                      imageSrc: AppIcons.vector,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30, // Adjust size
                                    backgroundImage: AssetImage(
                                      'assets/images/img.jpg',
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      CustomText(text: 'Jane Cooper Follow'),
                                      CustomText(text: 'with Jane Cooper'),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              CustomText(
                                text:
                                    'That sounds awesome! 🎶 Which artists or bands were your favorite?',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                maxLines: 3,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.r),
                                  bottom: Radius.circular(10.r),
                                ),
                                child: CustomImage(imageSrc: AppImages.card),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomImage(imageSrc: AppImages.map),
                                  SizedBox(width: 10),
                                  CustomText(
                                    text:
                                        'Summer Music Festival   Central Park',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.green_01,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomImage(imageSrc: AppIcons.heart),
                                      CustomText(text: '24'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomImage(
                                        imageSrc: AppIcons.comments,
                                      ),
                                      CustomText(text: '6'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomImage(imageSrc: AppIcons.share),
                                      CustomText(text: '05'),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.r),
                                  bottom: Radius.circular(10.r),
                                ),
                                child: CustomImage(imageSrc: AppImages.card),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  CustomImage(imageSrc: AppImages.map),
                                  SizedBox(width: 10),
                                  CustomText(
                                    text:
                                        'Summer Music Festival   Central Park',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.green_01,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomImage(imageSrc: AppIcons.heart),
                                      CustomText(text: '24'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomImage(
                                        imageSrc: AppIcons.comments,
                                      ),
                                      CustomText(text: '6'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomImage(imageSrc: AppIcons.share),
                                      CustomText(text: '05'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
