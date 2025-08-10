import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key, this.img, this.title, this.subtitle, this.time,
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
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  CircleAvatar(
        //   radius: 30,
        //   backgroundImage: widget.img,
        // ),
        SizedBox(
          height:50 ,
          width: 50,
            child: CircleAvatar(
              backgroundImage: widget.img ,
            ),

        ),
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
                color: AppColors.green_01,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
