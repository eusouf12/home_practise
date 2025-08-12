import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomUpcomingEventCard extends StatefulWidget {
  const CustomUpcomingEventCard({super.key});

  @override
  State<CustomUpcomingEventCard> createState() => _CustomUpcomingEventCardState();
}

class _CustomUpcomingEventCardState extends State<CustomUpcomingEventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.dmUpcomingEventDetails);
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      Expanded(
                        child: Container(
                          height: 27.h,
                          width: 73.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: CustomText(
                            text: 'upcoming',
                            fontSize: 12,
                            color: AppColors.brown2,
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
