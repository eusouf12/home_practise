
import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomBookingCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? color;
  final Color? subtitleColor;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final FontWeight? titleFontWeight;
  final FontWeight? subtitleFontWeight;
  final double? imageWidth;
  final double? imageHeight;
  final ImageProvider? preImg;

  const CustomBookingCard({
    super.key,
    this.title,
    this.subtitle,
    this.color,
    this.subtitleColor,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleFontWeight,
    this.subtitleFontWeight,
    this.imageWidth = 36,
    this.imageHeight = 36,
    this.preImg,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image at
        Image(image: preImg ?? AssetImage(AppIcons.star) , width: imageWidth, height: imageHeight, fit: BoxFit.cover),

        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: (subtitle != null && subtitle!.isNotEmpty)
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            children: [
              CustomText(
                text: title ?? 'CityGroove Fest',
                color: color ?? Colors.black,
                fontSize: titleFontSize ?? 15.3,
                fontWeight: titleFontWeight ?? FontWeight.w600,
                right: 20,
              ),
              if (subtitle != null &&
                  subtitle!.isNotEmpty)
                CustomText(
                  text: subtitle!,
                  color: subtitleColor ?? AppColors.black_80,
                  fontSize: subtitleFontSize ?? 11.9,
                  fontWeight: subtitleFontWeight ?? FontWeight.w500,
                  maxLines: 10,
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ),
      ],
    );
  }
}