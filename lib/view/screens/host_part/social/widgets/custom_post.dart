import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/screens/host_part/social/widgets/comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomPost extends StatelessWidget {
  const CustomPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary, width: .1),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 60.h,
                  width: 60.w,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Alex Johnson",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: "@alexJhon - 2h ago",
                      fontSize: 12.w,
                      color: Color(0xff6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                Center(
                                  child: CustomText(
                                    text: "Report",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                  text: "Why are you reporting this post",
                                ),
                                const SizedBox(height: 20),

                                // Scrollable options
                                Expanded(
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Spam / Irrelevant Content"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Offensive / Abusive Language"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Hate Speech / Discrimination"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Fake / Misleading Information"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Scam / Fraud"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Sexual / Inappropriate Content"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Violence / Threat"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Copyright Violation"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: CustomText(text: "Other (Custom Reason)"),
                                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                                        onTap: () {
                                          Get.toNamed(AppRoutes.reportScreen);
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Next button
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                    title: "Next",
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.more_vert),
                )

              ],
            ),
            CustomText(
              text:
                  "That sounds awesome! 🎶 Which artists or bands were your favorite?",
              fontSize: 16.w,
              fontWeight: FontWeight.w400,
              maxLines: 10,
              textAlign: TextAlign.start,
              bottom: 10.h,
            ),
            CustomNetworkImage(
              imageUrl: AppConstants.ntrition,
              height: 200.h,
              borderRadius: BorderRadius.circular(20),
              width: MediaQuery.sizeOf(context).width,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                CustomImage(
                  imageSrc: AppIcons.mapMarker,
                ),
                CustomText(
                  text: "Summer Music Festival - Central Park",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      color: AppColors.red,
                    ),
                    CustomText(
                      text: "24",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return CommentScreen(postId: '', userId: '',);
                          },
                        );
                      },
                      icon: Icon(Icons.mode_comment),
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text: "11",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share),
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text: "06",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
