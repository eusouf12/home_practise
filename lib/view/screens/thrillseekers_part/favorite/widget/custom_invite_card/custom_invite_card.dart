import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomInviteCard extends StatelessWidget {
  final String? title;
  final FontWeight? fontWeight;
  final double? fontSize;
  // ignore: non_constant_identifier_names
  final ImageProvider? Img;
  final Color borderColor;
  final Color? checkedColor;
  final double size;
  final bool isChecked;
  final ValueChanged<bool>? onChanged;
  final bool moreIcon;

  const CustomInviteCard({
    super.key,
    this.borderColor = Colors.black,
    this.checkedColor,
    this.size = 22,
    this.title,
    // ignore: non_constant_identifier_names
    this.Img,
    this.fontSize,
    this.fontWeight,
    required this.isChecked,
    this.onChanged,
     this.moreIcon =false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(imageUrl: AppConstants.girlsPhoto, height: 50.h, width: 50.w, boxShape: BoxShape.circle,),
        SizedBox(width: 20),
        CustomText(
          text: title ?? 'Ronald Richards',
          fontSize: fontSize ?? 20,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
        Spacer(),
       moreIcon == false ?  IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)):
        IconButton(
          icon: isChecked
              ? Icon(
            Icons.check,
            color: checkedColor ?? AppColors.primary,
            size: size,
          )
              : Icon(
            Icons.check_box_outline_blank,
            color: borderColor,
            size: size,
          ),
          onPressed: () {
            onChanged?.call(!isChecked);
          },
        ),
      ],
    );
  }
}
