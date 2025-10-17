import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomStory extends StatelessWidget {
  final String? img;
  final String? name;
  final VoidCallback? onTap;
  const CustomStory({super.key, this.img, this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
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
              imageUrl: img ?? AppConstants.girlsPhoto,
              height: 60.h,
              width: 60.w,
              boxShape: BoxShape.circle,
            ),
          ),
        ),
        CustomText(
          top: 4,
          text: name??" ",
          fontSize: 14.w,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
