import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveComment extends StatelessWidget {
  final String? title;
  final String? title2;
  final String? subtitle;
  final String? preImg;
  final ImageProvider? preIcon;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontWeight? fontWeight2;
  final double? fontSize2;
  final FontWeight? fontWeight3;
  final double? fontSize3;
  final Color? color3;
  final Color? color;
  final Color? color2;
  final bool isPreIcon;
  final bool isTrue;
  final bool isCount;
  final Color? fillcolor;
  final double? preIconHeight;
  final double? preIconweight;
  final double ticketPrice;
  final Function(int count, double totalPrice)? onCountChanged;
  final int? externalCount;
  final double? externalTotalPrice;

  const CustomLiveComment({
    super.key,
    this.preIconHeight,
    this.preIconweight,
    this.preImg,
    this.preIcon,
    this.isPreIcon = false,
    this.title,
    this.title2,
    this.subtitle,
    this.fontWeight,
    this.fontSize,
    this.fontWeight2,
    this.fontSize2,
    this.fontWeight3,
    this.fontSize3,
    this.color3,
    this.color2,
    this.color,
    this.isTrue = false,
    this.isCount = false,
    this.fillcolor,
    this.ticketPrice = 20.0,
    this.onCountChanged,
    this.externalCount = 1,
    this.externalTotalPrice = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final int displayCount = externalCount ?? 1;
    final double displayTotalPrice = externalTotalPrice ?? ticketPrice;

    return Card(
      margin: EdgeInsets.zero,
      color: fillcolor ?? Colors.transparent,
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: isPreIcon
                ? (preIcon != null
                ? Image(
              image: preIcon!,
              width: preIconweight ?? 25,
              height: preIconHeight ?? 25,
              fit: BoxFit.cover,
            )
                : const SizedBox.shrink())
                : CustomNetworkImage(
              imageUrl: preImg ?? AppConstants.profileImage,
              height: 32.h,
              width: 32.w,
              boxShape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: title ?? 'Angel',
                      color: color ?? Colors.black,
                      fontSize: fontSize ?? 14,
                      fontWeight: fontWeight ?? FontWeight.w500,
                      right: 20,
                    ),
                    ...(!isTrue
                        ? [
                      CustomText(
                        text: isCount
                            ? "Count: $displayCount | Total: \$${displayTotalPrice.toStringAsFixed(2)}"
                            : title2 ?? '',
                        color: color2 ?? AppColors.black_80,
                        fontSize: fontSize2 ?? 10.2,
                        fontWeight: fontWeight2 ?? FontWeight.w500,
                      ),
                    ]
                        : [
                      const Spacer(),
                      isCount
                          ? Container(
                        height: 30,
                        padding: const EdgeInsets.all(2),
                        constraints: const BoxConstraints(
                          minWidth: 77,
                          maxWidth: 120,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.white_50),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                if (displayCount > 1) {
                                  onCountChanged?.call(
                                    displayCount - 1,
                                    ticketPrice * (displayCount - 1),
                                  );
                                }
                              },
                              child: Container(
                                height: double.infinity,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.primary3,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.remove,
                                    size: 16, color: Colors.black),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '$displayCount',
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                onCountChanged?.call(
                                  displayCount + 1,
                                  ticketPrice * (displayCount + 1),
                                );
                              },
                              child: Container(
                                height: double.infinity,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.primary3,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.add,
                                    size: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                          : CustomText(
                        text: title2 ??
                            "\$${displayTotalPrice.toStringAsFixed(2)}",
                        color: color2 ?? AppColors.black_80,
                        fontSize: fontSize2 ?? 10.2,
                        fontWeight:
                        fontWeight2 ?? FontWeight.w500,
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 5.h),
                CustomText(
                  text: subtitle ?? " ",
                  maxLines: 10,
                  fontSize: fontSize3 ?? 12,
                  fontWeight: fontWeight3 ?? FontWeight.w500,
                  color: color3 ?? AppColors.black_80,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}