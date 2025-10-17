import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class MiddleDetails extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? location;
  final String? date;
  final ImageProvider? preIcon;
  final bool isPreIcon;
  final bool? isTrue;

  const MiddleDetails({
    this.preIcon,
    this.isPreIcon = false,
    this.title,
    this.subtitle, this.location, this.date,  this.isTrue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: isTrue == true
                    ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r), // optional: square with rounded corners
                )
                    : null, // no background if false
                alignment: Alignment.center,
                child: Icon(
                  Icons.event,
                  color: AppColors.black_02,
                  size: 20.sp,
                ),
              ),

              SizedBox(width: 10.w),
              Expanded(
                child: CustomText(
                  text: title ?? 'Angel',
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  right: 20,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: isTrue == true
                      ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r), // optional: square with rounded corners
                  )
                      : null, // no background if false
                  alignment: Alignment.center,
                  child: Icon(Icons.calendar_month_outlined, color: AppColors.black_02,)),
              SizedBox(width: 10.w),
              CustomText(
                text: date ?? '',
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                right: 20,
                maxLines: 2,
              )
            ],
          ),
           SizedBox(height: 16),
          Row(
            children: [
              Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: isTrue == true
                      ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r), // optional: square with rounded corners
                  )
                      : null, // no background if false
                  alignment: Alignment.center,
                  child: Icon(Icons.location_on_outlined, color: AppColors.black_02,)),
              SizedBox(width: 10.w),
              CustomText(
                text: location ?? '',
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                right: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}
