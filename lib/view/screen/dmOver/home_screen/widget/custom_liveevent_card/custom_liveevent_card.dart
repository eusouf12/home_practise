import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveEventCard extends StatefulWidget {
  const CustomLiveEventCard({super.key});

  @override
  State<CustomLiveEventCard> createState() => _CustomLiveEventCardState();
}

class _CustomLiveEventCardState extends State<CustomLiveEventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.dmLiveEventDetails);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/card.png',
              fit: BoxFit.cover,
              height: 158.h,
              width: double.infinity,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Summer Music Festival',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      Expanded(
                        child: Container(
                          height: 27.h,
                          width: 73.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.green_01,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(
                                imageSrc: AppIcons.live,
                                imageColor: AppColors.red,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 2.95.w),
                              CustomText(
                                text: 'live',
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 9.h),

                  // Date & Time
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.calender,
                        imageColor: AppColors.black2,
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      CustomText(
                        text: 'Aug 15, 2025 • 4:00PM',
                        fontSize: 14,
                        color: AppColors.black2,
                      ),
                    ],
                  ),
                  SizedBox(height: 21.5.h),

                  // Attendees
                  Row(
                    children: [
                      CustomImage(
                        imageSrc: AppIcons.users,
                        imageColor: AppColors.black2,
                        height: 20.h,
                        width: 20.w,
                      ),
                      SizedBox(width: 10.w),
                      CustomText(
                        text: '245 attendees',
                        fontSize: 14,
                        color: AppColors.black2,
                      ),
                      Spacer(),
                      CustomImage(
                        imageSrc: AppIcons.pen,
                        imageColor: AppColors.black2,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
