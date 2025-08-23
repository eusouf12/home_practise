import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomGalleryCard extends StatefulWidget {
  final String? img;
  final String? title;

  const CustomGalleryCard({super.key, this.img, this.title});

  @override
  State<CustomGalleryCard> createState() => _CustomGalleryCardState();
}

class _CustomGalleryCardState extends State<CustomGalleryCard> {
  bool isLiked = false;
  int likeCount = 24;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(imageUrl: AppConstants.resturentImage, height: 244.h, width: double.infinity),

            // Bottom content section
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Title and Status
                  CustomText(
                    text: widget.title ?? 'By Alex k.',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked; // Toggle like status
                            // Increment or decrement count based on like status
                            if (isLiked) {
                              likeCount++; // Increase count when liked
                            } else {
                              likeCount--; // Decrease count when unliked
                            }
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 18.r,
                          color: isLiked ? AppColors.red : AppColors.black_02,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        text: '$likeCount',
                        fontSize: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}