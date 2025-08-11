import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveComment extends StatefulWidget {
  const CustomLiveComment({super.key});

  @override
  State<CustomLiveComment> createState() => _CustomLiveCommentState();
}

class _CustomLiveCommentState extends State<CustomLiveComment> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: 'Angel',
                          color: Colors.black,
                          fontSize: 11.9,
                          fontWeight: FontWeight.w500,
                          right: 20,
                        ),
                        CustomText(
                          text: '01:31',
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 10.2,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      text: "I've been to their previous events. The music is always top notch!",
                      maxLines: 10,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.grey,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
