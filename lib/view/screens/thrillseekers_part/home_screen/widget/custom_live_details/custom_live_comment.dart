import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveComment extends StatefulWidget {
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
  final double ticketPrice; // Price per ticket
  final Function(int count, double totalPrice)?
  onCountChanged; // Callback for count changes
  final int? externalCount; // External count from another card
  final double? externalTotalPrice; // External total price from another card

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
    this.externalCount, // NEW: External count
    this.externalTotalPrice, // NEW: External total price
  });

  @override
  State<CustomLiveComment> createState() => _CustomLiveCommentState();
}

class _CustomLiveCommentState extends State<CustomLiveComment> {
  int count = 1; // Initial count
  double totalPrice = 20.0; // Initial total price

  @override
  void initState() {
    super.initState();
    totalPrice = widget.ticketPrice * count;
  }

  void incrementCount() {
    setState(() {
      count++;
      totalPrice = widget.ticketPrice * count;
    });

    // Call the callback if provided
    if (widget.onCountChanged != null) {
      widget.onCountChanged!(count, totalPrice);
    }
  }

  void decrementCount() {
    if (count > 1) {
      setState(() {
        count--;
        totalPrice = widget.ticketPrice * count;
      });

      // Call the callback if provided
      if (widget.onCountChanged != null) {
        widget.onCountChanged!(count, totalPrice);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use external values if provided, otherwise use internal state
    int displayCount = widget.externalCount ?? count;
    double displayTotalPrice = widget.externalTotalPrice ?? totalPrice;

    return Card(
      margin: EdgeInsets.zero,
      color: widget.fillcolor ?? Colors.transparent,
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: widget.isPreIcon
                ? (widget.preIcon != null
                      ? Image(
                          image: widget.preIcon!,
                          width: widget.preIconweight ?? 25,
                          height: widget.preIconHeight ?? 25,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink())
                : CustomNetworkImage(
              imageUrl: widget.preImg ?? AppConstants.profileImage,
              height: 32.h,
              width: 32.w,
              boxShape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: widget.title ?? 'Angel',
                      color: widget.color ?? Colors.black,
                      fontSize: widget.fontSize ?? 14,
                      fontWeight: widget.fontWeight ?? FontWeight.w500,
                      right: 20,
                    ),
                    ...(!widget.isTrue
                        ? [
                            CustomText(
                              text: widget.isCount
                                  ? "Count: $displayCount | Total: \$${displayTotalPrice.toStringAsFixed(2)}"
                                  : widget.title2 ?? '',
                              color: widget.color2 ?? AppColors.black_80,
                              fontSize: widget.fontSize2 ?? 10.2,
                              fontWeight: widget.fontWeight2 ?? FontWeight.w500,
                            ),
                          ]
                        : [
                            const Spacer(),
                            widget.isCount
                                ?
                                Container(
                                    height: 30,
                                    padding: const EdgeInsets.all(2),
                                    constraints: BoxConstraints(
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
                                          onTap: decrementCount,
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
                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                            child: Text(
                                              '$displayCount',
                                              style: const TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: incrementCount,
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
                                    text:
                                        widget.title2 ??
                                        "\$${displayTotalPrice.toStringAsFixed(2)}",
                                    color: widget.color2 ?? AppColors.black_80,
                                    fontSize: widget.fontSize2 ?? 10.2,
                                    fontWeight:
                                        widget.fontWeight2 ?? FontWeight.w500,
                                  ),
                          ]),
                  ],
                ),
                SizedBox(height: 5.h),
                //subtitle
                CustomText(
                  text: widget.subtitle ?? " ",
                  maxLines: 10,
                  fontSize: widget.fontSize3 ?? 12,
                  fontWeight: widget.fontWeight3 ?? FontWeight.w500,
                  color: widget.color3 ?? AppColors.black_80,
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