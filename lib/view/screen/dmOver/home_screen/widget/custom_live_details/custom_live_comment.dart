import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomLiveComment extends StatefulWidget {
  final String? title;
  final String? title2;
  final String? subtitle;
  final ImageProvider? preImg;
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
  final bool isTrue2;
  final Color? fillcolor;
  final double? preIconHeight;
  final double? preIconweight;

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
    this.fontSize ,
    this.fontWeight2,
    this.fontSize2,
    this.fontWeight3,
    this.fontSize3 ,
    this.color3,this.color2,this.color,
    this.isTrue = false,
    this.isTrue2 = false,
    this.fillcolor,
  });

  @override
  State<CustomLiveComment> createState() => _CustomLiveCommentState();
}

class _CustomLiveCommentState extends State<CustomLiveComment> {
  @override
  Widget build(BuildContext context) {
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
                  width: widget.preIconweight??25,
                  height: widget.preIconHeight??25,
                  fit: BoxFit.cover,
                )
                    :  const SizedBox.shrink())
                    : CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent, // no bg color
                  backgroundImage:
                  widget.preImg ?? const AssetImage(AppImages.profile),
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
                        ...(!widget.isTrue ? [
                          CustomText(
                            text: widget.title2 ?? '',
                            color: widget.color2 ?? AppColors.grey,
                            fontSize: widget.fontSize2 ?? 10.2,
                            fontWeight: widget.fontWeight2 ?? FontWeight.w500,
                          ),
                        ] : [
                          const Spacer(),
                          widget.isTrue2
                              ?
                          SizedBox(
                            width: 77,
                            height: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey_09),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // decrease logic
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.color3,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.remove, size: 16, color: Colors.black),
                                    ),
                                  ),
                                  const Text(
                                    '1',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // increase logic
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.color3,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.add, size: 16, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )


                              : CustomText(
                            text: widget.title2 ?? '',
                            color: widget.color2 ?? AppColors.grey,
                            fontSize: widget.fontSize2 ?? 10.2,
                            fontWeight: widget.fontWeight2 ?? FontWeight.w500,
                          )

                        ]),
                      ],
                    ),

                    SizedBox(height: 5.h),
                    CustomText(
                      text: widget.subtitle ?? " ",
                      maxLines: 10,
                      fontSize: widget.fontSize3 ?? 12,
                      fontWeight: widget.fontWeight3 ??FontWeight.w500,
                      color: widget.color3 ?? AppColors.grey,
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
