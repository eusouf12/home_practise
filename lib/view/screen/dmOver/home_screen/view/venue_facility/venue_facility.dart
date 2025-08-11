import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/custom_facility_card/custom_facility_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class VenueFacility extends StatefulWidget {
  const VenueFacility({super.key});

  @override
  State<VenueFacility> createState() => _VenueFacilityState();
}

class _VenueFacilityState extends State<VenueFacility> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  leading: Container(
                    height: 38.5.h,
                    width: 38.5.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: BackButton(color: AppColors.black),
                  ),
                  title: CustomText(
                    text: "Venue Facilities",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  preicon: CustomImage(imageSrc: AppIcons.washroom),
                  posticon: CustomImage(imageSrc: AppIcons.downarraw),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Hand Wash Station",
                  preicon: CustomImage(imageSrc: AppIcons.wash),
                  posticon: CustomImage(imageSrc: AppIcons.downarraw),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Smoking Zone",
                  preicon: CustomImage(imageSrc: AppIcons.smoking),
                  posticon: CustomImage(imageSrc: AppIcons.downarraw),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Food Court",
                  preicon: CustomImage(imageSrc: AppIcons.eat),
                  posticon: CustomImage(imageSrc: AppIcons.downarraw),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Rest Area",
                  preicon: CustomImage(imageSrc: AppIcons.bed),
                  posticon: CustomImage(imageSrc: AppIcons.downarraw),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
