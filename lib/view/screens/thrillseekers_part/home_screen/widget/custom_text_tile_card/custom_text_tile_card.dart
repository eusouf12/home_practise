import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomTextTileCard extends StatefulWidget {
  final String? profileImage;
  final String? name;
  final int? followers;
  final VoidCallback? onMessageTap;

  const CustomTextTileCard({
    super.key,
    this.profileImage,
    this.name,
    this.followers = 45,
    this.onMessageTap,
  });

  @override
  State<CustomTextTileCard> createState() => _CustomTextTileCardState();
}

class _CustomTextTileCardState extends State<CustomTextTileCard> {
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(
          imageUrl: AppConstants.profileImage,
          height: 50.h,
          width: 50.w,
          boxShape: BoxShape.circle,
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Name + Follow
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.name ?? 'Alex Willam ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFollowing = !isFollowing;
                        });
                      },
                      child: Text(
                        isFollowing ? 'Following' : 'Follow',
                        style: TextStyle(
                          color:AppColors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            // with others
            Row(
              children: [
                CustomText(
                  text: widget.followers.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.black_80,
                ),
                CustomText(
                  text: "Followers",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.black_80,
                  left: 4,
                ),
              ],
            ),
            SizedBox(height: 4.h),
            // username + Time
            GestureDetector(
              onTap: widget.onMessageTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 44, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(39.r),
                ),
                child: CustomText(
                  text: "Message",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}