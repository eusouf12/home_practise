import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveDetails extends StatefulWidget {
  const CustomLiveDetails({super.key});

  @override
  State<CustomLiveDetails> createState() => _CustomLiveDetailsState();
}

class _CustomLiveDetailsState extends State<CustomLiveDetails> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 12,top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==== Profile
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppImages.image1),
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
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Follow',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
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
                    color: AppColors.black_80,
                  ),

                  // username + Time
                  Row(
                    children: [
                      CustomText(
                        text: "@alexJhon",
                        fontSize: 12,
                        color: AppColors.black_80,
                        right: 5.w,
                      ),
                      Container(
                        height: 5.h,
                        width: 5.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.black_80,
                        ),
                      ),
                      CustomText(
                        text: "  2h ago",
                        fontSize: 12,
                        color: AppColors.black_80,
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
          CustomNetworkImage(
            imageUrl: AppConstants.ntrition,
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            borderRadius: BorderRadius.circular(15),
          ),

          SizedBox(height: 10.h),

          // location +center park
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomImage(
                imageSrc: AppIcons.star,
                imageColor: AppColors.primary,
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
                      color: AppColors.primary,
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
                        color: AppColors.primary,
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
              //love
              Row(
                children: [
                  CustomImage(
                    imageSrc: AppIcons.star,
                    imageColor: AppColors.red,
                    height: 20.h,
                    width: 19.w,
                  ),
                  CustomText(text: '24', left: 4.w),
                ],
              ),
              //text
              Row(
                children: [
                  CustomImage(imageSrc: AppIcons.star),
                  CustomText(text: '6', left: 4.w),
                ],
              ),
              Row(
                children: [
                  CustomImage(
                    imageSrc: AppIcons.star,
                    height: 20.h,
                    width: 19.w,
                  ),
                  CustomText(text: '05', left: 4.w),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}