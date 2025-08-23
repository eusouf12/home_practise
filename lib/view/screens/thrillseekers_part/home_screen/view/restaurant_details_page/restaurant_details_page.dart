import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../widget/custom_text_tile_card/custom_text_tile_card.dart';
import '../../widget/overlapping_card_count/overlapping_card_count.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "The Codfather",
          leftIcon: true,
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 23, bottom: 65),
          child: Column(
            children: [
              // First Section (Event Image & Info)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomNetworkImage(
                            imageUrl: AppConstants.ntrition, height: 310, width: double.infinity,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        Positioned(
                          top: 17,
                          left: 20,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.greyLight,
                            ),
                            alignment: Alignment.center,
                            child: CustomText(
                              text: 'Restaurants',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.greyLight,
                            ),
                            child: const Icon(
                              Icons.share,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'The Codfather',
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),

                          CustomText(
                            text: 'New York, NY',
                            color: AppColors.black_80,
                            fontSize: 16,
                            bottom: 11,
                            top: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 29),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.galleryScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(53.r),
                        ),
                        child: CustomText(
                          text: "Gallery",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.updateScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary6,
                          borderRadius: BorderRadius.circular(53.r),
                        ),
                        child: CustomText(
                          text: "Update & Reports",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // profile +and follow
              const SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomTextTileCard(),
              ),
              //About Bar
              const SizedBox(height: 36),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'About Bar',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    CustomText(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis ante elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis ante elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis ante elit.",
                      fontSize: 14,
                      color: AppColors.black_80,
                      textAlign: TextAlign.left,
                      maxLines: 10,
                      bottom: 25,
                      top: 8,
                    ),

                    CustomText(
                      text: 'Join the event',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      bottom: 8,
                    ),

                    OverlappingCardCount(
                      imageUrls: [
                        AppConstants.profileImage,
                        AppConstants.profileImage,
                       AppConstants.profileImage,
                       AppConstants.profileImage,
                      ],
                      totalCount: 14,
                    ),
                  ],
                ),
              ),
              // Location and map
              const SizedBox(height: 45),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //location icon
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 6.w),

                        CustomText(
                          text: 'Location',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),

                    CustomText(
                      text:
                          '55 Hudson Yards, 10th FloorNew York, NY 10001, United States',
                      fontSize: 16,
                      color: AppColors.black_80,
                      textAlign: TextAlign.left,
                      maxLines: 10,
                      bottom: 24,
                      top: 10,
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 29,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(53.r),
                      ),
                      child: CustomText(
                        text: "Map",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
