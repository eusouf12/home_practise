import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';

class DmHomeScreen extends StatefulWidget {
  const DmHomeScreen({super.key});

  @override
  State<DmHomeScreen> createState() => _DmHomeScreenState();
}

class _DmHomeScreenState extends State<DmHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 50.h,
                    width: 50.w,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Good Morning",
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      CustomText(
                        text: "Alexa",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.notificationScreen);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF7FFEF),
                  ),
                  child: CustomImage(imageSrc: AppIcons.notification),
                ),
              ),
            ],
          ),
        ),

        //body
        body: Padding(
          padding: EdgeInsets.only(
              left: 20.w, right: 20.w, top: 10, bottom: 26.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Find Best Events
              CustomText(
                text: 'Find Best Events\nNear You',
                textAlign: TextAlign.left,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Explore events',
                hintStyle: TextStyle(color: AppColors.black_80),
                fieldBorderRadius: 15,
                fieldBorderColor: AppColors.white,
                fillColor: AppColors.white,
                prefixIcon: Icon(Icons.search, color: AppColors.primary),

              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      onTap: () {
                        Get.toNamed(AppRoutes.dmFilter);
                      },
                      hintText: "Event Filters",
                      fieldBorderRadius: 50,
                      fillColor: AppColors.white,
                      hintStyle: TextStyle(color: AppColors.black_80),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: CustomImage(imageSrc: AppIcons.menu,imageColor: AppColors.black_80,),
                      ),
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                      readOnly: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: CustomTextField(
                      onTap: () {
                        Get.toNamed(AppRoutes.barRestaurants);
                      },
                      hintStyle: TextStyle(color: AppColors.black_80),
                      hintText: "      Non-Events",
                      fieldBorderRadius: 50,
                      fillColor: AppColors.white,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19.5),

              //  Find events near
              RichText(
                text: TextSpan(
                  text: 'Find events near.  ',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16.w,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'New York, NY',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.location_on_outlined),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Live Event
              Row(
                children: [
                  Icon(Icons.circle, size:20, color: AppColors.red),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmLiveScreen);
                    },
                    child: CustomText(
                      text: "Live Event",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black_80,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.circle, size: 20, color: Color(0xFF53CCB1)),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmUpcomingEventScreen);
                    },
                    child: CustomText(
                      text: "Up Coming Live",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black_80,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),

              // live location
              Expanded(
                child: CustomImage(
                  imageSrc: AppImages.mapImage,
                  height: 287,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DmNavBar(currentIndex: 0),
      ),
    );
  }
}
