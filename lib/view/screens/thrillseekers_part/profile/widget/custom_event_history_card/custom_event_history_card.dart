import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomEventHistoryCard extends StatefulWidget {
  final String? title;
  final String? location;
  final String? date;
  final String? startTime;
  final String? endTime;
  final bool? inPerson;
  final bool? iscompleted;


  const CustomEventHistoryCard({super.key,
    this.title, this.location,
    this.date, this.startTime,
    this.endTime,
    this.inPerson=false,
    this.iscompleted=false,
  });

  @override
  State<CustomEventHistoryCard> createState() => _CustomEventHistoryCardState();
}

class _CustomEventHistoryCardState extends State<CustomEventHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'CityGroove Fest',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              (widget.iscompleted !=true)?
                  //upcoming
              Row(
                children: [
              CustomImage(imageSrc: AppIcons.calenderIcon,imageColor: AppColors.primaryLight,),
                  const SizedBox(width: 8),
                  CustomText(
                    text: 'Upcoming',
                    color: AppColors.black_80,
                  ),
                ],
              )
              :
              Row(
                children: [
                  CustomImage(imageSrc: AppIcons.tikIcon,imageColor: AppColors.primaryLight,),
                  const SizedBox(width: 8),
                  CustomText(
                    text: 'Completed',
                    color: AppColors.primaryLight,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 17),

          /// Date & Time
          Row(
            children: [
              CustomImage(imageSrc: AppIcons.calender),
              const SizedBox(width: 5),
              CustomText(
                text: '2025-11-15',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
                left: 8,
                right: 10,
              ),
              Icon(Icons.circle, size: 5, color: AppColors.black_80),
              CustomText(
                text: '18:00 - 20:00',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                left: 10,
                color: AppColors.black_80,
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Location
          Row(
            children: [
              CustomImage(imageSrc: AppIcons.locationIcon),
              const SizedBox(width: 5),
              CustomText(
                text: 'Digital Innovation Hub',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
                left: 8,
                right: 10,
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Event Type
          Row(
            children: [
              CustomText(text: 'Event Type:', right: 16),
              (widget.inPerson != true)
                  ? Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.black_80,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CustomText(text: 'In-person',color: AppColors.black_80,),
              )
                  : Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFF3E8FF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CustomText(text: 'Upcoming',color: AppColors.black_80,),
              ),
            ],
          ),

          //rating
          SizedBox(height: 21,),
          CustomText(text: 'Your rating:  🔥', fontSize: 14, fontWeight: FontWeight.w400,),
          SizedBox(height: 24,),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    children: [
                     Icon(Icons.remove_red_eye,color: AppColors.black_02,),
                      CustomText(text: 'View Event', left: 6,)
                    ],
                  )
              ),
              SizedBox(width: 10,),
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.image,color: AppColors.black_02,),
                      CustomText(text: 'View Media',left: 6, )
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
