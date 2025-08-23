import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomStory extends StatelessWidget {
  const CustomStory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(4), // space for gradient border
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.primary, Colors.amber],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CustomNetworkImage(
            imageUrl: AppConstants.girlsPhoto,
            height: 60.h,
            width: 60.w,
            boxShape: BoxShape.circle,
          ),
        ),
        CustomText(
          top: 4,
          text: "Alex",
          fontSize: 14.w,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
