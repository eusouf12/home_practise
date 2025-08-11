import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveDetails extends StatefulWidget {
  const CustomLiveDetails({super.key});

  @override
  State<CustomLiveDetails> createState() => _CustomLiveDetailsState();
}

class _CustomLiveDetailsState extends State<CustomLiveDetails> {
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==== Profile
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Follow
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Jene Cooper ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Follow',
                          style: TextStyle(
                            color: AppColors.green_01,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),

                  // with others
                  CustomText(
                    text: "with Jane Cooper and 5 others",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.grey,
                  ),

                  // username + Time
                  Row(
                    children: [
                      CustomText(
                        text: "@alexJhon",
                        fontSize: 12,
                        color: AppColors.grey2,
                        right: 5.w,
                      ),
                      Container(
                        height: 5.h,
                        width: 5.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey2,
                        ),
                      ),
                      CustomText(
                        text: "  2h ago",
                        fontSize: 12,
                        color: AppColors.grey2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 17.h),

          // Post Text
          CustomText(
            text: 'That sounds awesome! 🎶 Which artists or bands were your favorite?',
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            maxLines: 10,
          ),

          SizedBox(height: 10.h),

          // ==== Post Image ====
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CustomImage(imageSrc: AppImages.card),
          ),

          SizedBox(height: 10.h),

          // location +center park
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomImage(
                imageSrc: AppIcons.location,
                imageColor: AppColors.green_01,
                height: 20.h,
                width: 20.w,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: 'Summer Music Festival',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green_01,
                    ),

                    Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),


                    Flexible(
                      child: CustomText(
                        text: 'Central Park',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green_01,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),


          SizedBox(height: 11.h),

          //  Likes / Comments + Share
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomImage(
                    imageSrc: AppIcons.heart,
                    imageColor: AppColors.red,
                    height: 20.h,
                    width: 19.w,
                  ),
                  CustomText(text: '24', left: 4.w),
                ],
              ),
              Row(
                children: [
                  CustomImage(imageSrc: AppIcons.comments),
                  CustomText(text: '6', left: 4.w),
                ],
              ),
              Row(
                children: [
                  CustomImage(
                    imageSrc: AppIcons.share,
                    height: 20.h,
                    width: 19.w,
                  ),
                  CustomText(text: '05', left: 4.w),
                ],
              ),
            ],
          ),

          SizedBox(height: 30.h),
        ],
      ),

    );
  }
}