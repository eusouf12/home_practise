import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/custom_text/custom_text.dart';
class EventPointCard extends StatelessWidget {
   const EventPointCard({super.key, this.point, this.title});
  final String? point;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.all(4),
        height: 118.h,
        width: MediaQuery.sizeOf(context).width / 3.6,
       // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: point ?? "3",
              fontSize: 24.w,
              fontWeight: FontWeight.w600,
            ),
            CustomText(
              text: title?? "Events",
              fontSize: 16.w,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
