import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomBarCard extends StatelessWidget {
  final String? img;
  final String? imgName;
  final String? title;
  final double distance;
  final bool isFavorite;
  final VoidCallback? onViewDetails;
  final VoidCallback? onShareTap;
  final VoidCallback? onFavoriteTap;

  const CustomBarCard({
    super.key,
    this.img,
    this.imgName,
    this.title,
    this.distance = 0.0,
    this.isFavorite = false,
    this.onViewDetails,
    this.onShareTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: distance <= 1 ? AppColors.primary : AppColors.primary5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomNetworkImage(
                  imageUrl: img ?? AppConstants.ntrition,
                  height: 129.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(20),
                ),
                // category name
                Positioned(
                  top: 0,
                  left: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.white,
                    ),
                    child: CustomText(
                      text: imgName ?? "Bar",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // favorite icon (controller will handle logic)
                Positioned(
                  right: 3,
                  top: 3,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 20,
                        color: isFavorite
                            ? AppColors.primary
                            : AppColors.black_02,
                      ),
                    ),
                  ),
                ),
                // share icon
                Positioned(
                  right: 3,
                  bottom: 3,
                  child: GestureDetector(
                    onTap: onShareTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.white,
                      ),
                      child: const Icon(Icons.share, size: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            // title
            CustomText(
              text: title ?? '',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              top: 5,
              bottom: 5,
            ),
            // subtitle (distance)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: distance.toStringAsFixed(1),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFD2D2D2),
                  right: 4,
                ),
                const CustomText(
                  text: "km from you",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD2D2D2),
                ),
              ],
            ),
            // View Details
            GestureDetector(
              onTap: onViewDetails,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: CustomText(
                  text: 'View Details →',
                  color: const Color(0xFF4CAF50),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
