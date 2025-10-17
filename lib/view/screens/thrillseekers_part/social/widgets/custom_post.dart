import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';

import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomPost extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onTap2;
  const CustomPost({super.key, this.onTap, this.onTap2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: .1),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onTap2,
                    child: CustomNetworkImage(
                      imageUrl: AppConstants.profileImage,
                      height: 60.h,
                      width: 60.w,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Alex Johnson",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: "@alexJhon - 2h ago",
                        fontSize: 12.w,
                        color: Color(0xff6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )
                ],
              ),
              CustomText(
                text:
                "That sounds awesome! 🎶 Which artists or bands were your favorite?",
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                maxLines: 10,
                textAlign: TextAlign.start,
                bottom: 10.h,
              ),
              CustomNetworkImage(
                imageUrl: AppConstants.ntrition1,
                height: 200.h,
                borderRadius: BorderRadius.circular(20),
                width: MediaQuery.sizeOf(context).width,
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  CustomImage(
                    imageSrc: AppIcons.star,
                    imageColor: AppColors.primary,
                  ),
                  CustomText(text: "Summer Music Festival - Central Park", fontSize: 14.w,fontWeight: FontWeight.w500,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite),color: AppColors.red,),
                      CustomText(text: "24", fontSize: 14.w,fontWeight: FontWeight.w700,),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.mode_comment),color: AppColors.primary,),
                      CustomText(text: "6", fontSize: 14.w,fontWeight: FontWeight.w700,),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.share),color: AppColors.primary,),
                      CustomText(text: "06", fontSize: 14.w,fontWeight: FontWeight.w700,),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
