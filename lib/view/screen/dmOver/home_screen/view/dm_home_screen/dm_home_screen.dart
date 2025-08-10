import 'package:event_management/core/app_routes/app_routes.dart';
import 'package:event_management/utils/app_colors/app_colors.dart';
import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/utils/app_images/app_images.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/components/custom_images/custom_images.dart';
import 'package:event_management/view/components/custom_nav_bar/dm_navbar.dart';
import 'package:event_management/view/components/custom_test_field/custom_text_field.dart';
import 'package:event_management/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(AppImages.profile),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CustomImage(imageSrc: AppIcons.notificartion),
                ),
              ),
            ],
          ),
        ),

        //body
        body: Padding(
          padding: const EdgeInsets.only(left: 20.12, right: 20.12, top: 0,bottom: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Find Best Events\nNear You',
                textAlign: TextAlign.left,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 16),

              CustomTextField(
                hintText: 'Explore events',
                height: 60,
                weight: double.infinity,
                fieldBorderRadius: 15,
                prefixIcon: Icon(Icons.search, color: AppColors.green_01),
                prefixIconLeftPadding: 33.58,
                prefixIconRightPadding: 10,
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      onTap: () {
                        Get.toNamed(AppRoutes.hostHomeScreen);
                      },
                      hintText: "Event Filters",
                      color: AppColors.black,
                      height: 43,
                      weight: 180,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fieldBorderRadius: 50,
                      prefixIcon: Icon(
                        Icons.menu_outlined,
                        color: AppColors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.black,
                      ),
                      readOnly: true,
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: CustomTextField(
                      height: 43,
                      weight: 159,
                      color: AppColors.black,
                      hintText: "Bar & Resturent",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fieldBorderRadius: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 19.5),

              RichText(
                text: TextSpan(
                  text: 'Find events near',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: ' New York, NY',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.mode_edit_outline_sharp, size: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Row(
                children: [
                  Icon(Icons.circle, size: 8.69, color: AppColors.green_01),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmLiveScreen);
                    },
                    child: CustomText(
                      text: "Live Event",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black1,
                    ),
                  ),

                  SizedBox(width: 15),
                  Icon(Icons.circle, size: 8.69, color: AppColors.grey),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmUpcomingEventScreen);
                    },

                    child: CustomText(
                      text: "Up Coming Live",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),

              Expanded(
                child: CustomImage(
                  imageSrc: AppImages.map,
                  height: 287,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),

            ],
          ),
        ),
        bottomNavigationBar:DmNavBar(currentIndex: 0),

      ),
    );
  }
}