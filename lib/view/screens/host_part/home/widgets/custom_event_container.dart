import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomEventContainer extends StatelessWidget {
  const CustomEventContainer({
    super.key,
    this.title,
    this.img,
    this.date,
    this.startingTime,
    this.onTapUpdate,
    this.onTap,
    this.price= false,
    this.rating= false,
    this.attendees= false,
    this.update=false,
    this.liveButton=false,
    this.pastEvent=false,
    this.UpcomingEvent=false,
  });

  final String? title;
  final String? img;
  final VoidCallback? onTap;
  final VoidCallback? onTapUpdate;
  final bool price;
  final bool attendees;
  final bool update;
  final bool rating;
  final bool liveButton;
  final bool pastEvent;
  final bool UpcomingEvent;
  final String? date;
  final String? startingTime;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              CustomNetworkImage(
                imageUrl: img ?? AppConstants.ntrition1,
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                borderRadius: BorderRadius.circular(15),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: title ?? "Summer Music Festival",
                        textAlign: TextAlign.start,
                        fontSize: 18.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w), // spacing before buttons
                    liveButton == false
                        ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.video_call_outlined, color: AppColors.red, size: 16),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "Live",
                            fontSize: 12.w,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    )
                        : SizedBox(),

                    SizedBox(width: 6.w),
                    UpcomingEvent == false
                        ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffFEF9C3),
                      ),
                      child: CustomText(
                        text: "Upcoming",
                        fontSize: 12.w,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff854D0E),
                      ),
                    )
                        : Container(),

                    SizedBox(width: 6.w),

                    pastEvent == false
                        ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffFEC3C4),
                      ),
                      child: CustomText(
                        text: "Past",
                        fontSize: 12.w,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff854D0E),
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     children: [
                       CustomImage(imageSrc: AppIcons.calender),
                       CustomText(
                         left: 10.w,
                         text: "${date ?? "N/A"} : ${startingTime ?? "N/A"}",
                         fontSize: 14.w,
                         fontWeight: FontWeight.w400,
                       )
                     ],
                   ),
                  ],
                ),
              ),

             Padding(
               padding : const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
               child: Row(
                 children: [
                   attendees == true ?Row(
                     children: [
                       CustomImage(imageSrc: AppIcons.usersThree),
                       CustomText(
                         left: 10.w,
                         text: "245 attendees",
                         fontSize: 14.w,
                         fontWeight: FontWeight.w400,
                       ),
                     ],
                   ):Container(),
                   price == true ? Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       CustomText(text: "Price", fontSize: 16.w,fontWeight: FontWeight.w500,),
                       CustomText(text: "\$20",left: 10.w, fontSize: 16.w,fontWeight: FontWeight.w500,),
                     ],
                   ):Container(),
                   Spacer(),
                   update == true ? GestureDetector(onTap:onTapUpdate, child: CustomImage(imageSrc: AppImages.pen)) : Container(),
                   rating == true ? Row(
                     children: [
                       CustomImage(imageSrc: AppIcons.star,height: 16.w,width: 16.w,),
                       CustomText(
                         left: 10.w,
                         text: "4.8 Ratings",
                         fontSize: 14.w,
                         fontWeight: FontWeight.w400,
                       ),
                     ],
                   ):Container(),
                 ],
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
