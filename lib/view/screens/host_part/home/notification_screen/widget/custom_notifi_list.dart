import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';


class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,
    this.img,
    this.title,
    this.subtitle,
    this.time,
  });

  final ImageProvider? img;
  final String? title;
  final String? subtitle;
  final String? time;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 20, left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         CustomNetworkImage(imageUrl: AppConstants.girlsPhoto, height: 50.h, width: 50.w, boxShape: BoxShape.circle,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                CustomText(
                  text: widget.title ?? " ",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  maxLines: 10,
                  textAlign: TextAlign.left,
                  left: 16,
                  right: 16,
                ),
                SizedBox(height: 4,),
                CustomText(
                  text: widget.subtitle?? " ",
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
              CustomText(text:widget.time ?? '',
                fontSize: 14,

              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}