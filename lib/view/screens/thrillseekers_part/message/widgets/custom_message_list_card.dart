import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({
    super.key,
    this.icon1,
    this.icon2,
    this.img,
    this.title,
    this.subtitle,
    this.time,
  });

  final String? img;
  final String? title;
  final String? subtitle;
  final String? time;
  final Icon? icon1;
  final Icon? icon2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
       padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF96C9B8), width: .8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.girlsPhoto,
                height: 50.h,
                width: 50.w,
                boxShape: BoxShape.circle,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title ?? " ",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      maxLines: 10,
                      textAlign: TextAlign.left,
                      left: 16,
                      right: 16,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CustomText(
                      text: subtitle ?? " ",
                      fontSize: 14,
                      color: AppColors.black_02,
                      left: 16,
                      right: 16,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CustomText(
                    text: time ?? '',
                    fontSize: 14,
                  ),
                  icon1 ?? SizedBox(),
                ],
              ),
              /*SizedBox(
                width: 19,
              ),
              icon2 ?? SizedBox(),*/
            ],
          ),
        ),
      ),
    );
  }
}
