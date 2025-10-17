import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';


class CustomCommonDetailsBrCard extends StatelessWidget {
  final String? title;
  final String? address;
  final String? image;
  final String? type;
  final double? lat;
  final double? lon;
  final VoidCallback onSharePressed;
  final VoidCallback onGalleryPressed;

   const CustomCommonDetailsBrCard({super.key, this.title, this.address, this.image, this.type, this.lat, this.lon,required this.onSharePressed, required this.onGalleryPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // First Section (Event Image & Info)
          Container(

            decoration: BoxDecoration(
                color: AppColors.white,
              borderRadius:BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomNetworkImage(
                          imageUrl: image!, height: 310, width: double.infinity,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.greyLight,
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: type!,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: GestureDetector(
                        onTap: onSharePressed,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.greyLight,
                          ),
                          child: const Icon(
                            Icons.share,
                            size: 16,
                            color: AppColors.black,
                          ),
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
                    children:  [
                      CustomText(
                        text: title!,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),

                      CustomText(
                        text: address!,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        color: AppColors.black,
                        fontSize: 16,
                        bottom:11 ,
                        top: 6,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onGalleryPressed,
                    // Get.toNamed(AppRoutes.galleryScreen, arguments:event.id);
                    // debugPrint(event.id);
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.78,
                    padding: EdgeInsets.symmetric(vertical: 18),
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
              ],
            ),
          ),

          // Location a map
          const SizedBox(height: 15),
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
                      text: AppStrings.location,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),

                CustomText(
                  text: address!,
                  fontSize: 16,
                  color: AppColors.black,
                  textAlign: TextAlign.left,
                  maxLines: 10,
                  bottom: 24,
                  top: 10,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 29,vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(53.r),
                  ),
                  child: CustomText(
                    text: AppStrings.map,
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
    );
  }
}
