import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_loader/custom_loader.dart';
import 'package:event_platform/view/screens/host_part/social/model/socal_feed_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/social_controller.dart';

class DynamicCustomPost extends StatelessWidget {
  final String name;
  final String? profileImage;
  final DateTime time;
  final String caption;
  final String? postImage;
  final int? totalReacts;
  final int? totalComments;
  final String? userName;
  final int? share;
  final bool isReacted;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onFollowPressed;
  final VoidCallback? onProfileClicked;
  final bool? isFollowed;
  final VoidCallback? onSharePressed;
  final PostModel? post;

  const DynamicCustomPost({
    super.key,
    required this.name,
    this.profileImage,
    this.userName,
    required this.time,
    required this.caption,
    this.postImage,
    this.totalReacts,
    this.totalComments,  this.share,  required this.isReacted,  this.onLikePressed,  this.onCommentPressed,  this.onFollowPressed, this.onProfileClicked, this.isFollowed,  this.onSharePressed,  this.post,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("DynamicCustomPost received postImage URL: $postImage");
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary, width: .1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onProfileClicked,
                  child: CustomNetworkImage(
                    imageUrl: profileImage ?? AppConstants.profileImage,
                    height: 50.h,
                    width: 50.w,
                    boxShape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: name,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: onFollowPressed,
                          child: CustomText(
                            text: isFollowed == true ? 'Following' : 'Follow',
                            fontSize: 14.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: '@${userName ?? ''}',
                          fontSize: 12.w,
                          color: const Color(0xff6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                        CustomText(
                          left: 20,
                          text: timeago.format(time),
                          fontSize: 12.w,
                          color: const Color(0xff6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showReportBottomSheet(context);
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
            SizedBox(height: 10.h),
            CustomText(
              text: caption,
              fontSize: 16.w,
              fontWeight: FontWeight.w400,
              maxLines: 10,
              textAlign: TextAlign.start,
              bottom: 10.h,
            ),
            if (postImage != null && postImage!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: CustomNetworkImage(
                  imageUrl: postImage?? "",
                  // imageUrl: postImage ?? AppConstants.profileImage,
                  height: 200.h,
                  borderRadius: BorderRadius.circular(20),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onLikePressed,
                          child: Icon(
                            Icons.favorite,
                            size: 35.r,
                            color: isReacted ? AppColors.red : AppColors.black_02,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        CustomText(
                          text: "${totalReacts}",
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    // _buildStatRow(
                    //   icon: Icons.mode_comment,
                    //   color: AppColors.primary,
                    //   count: totalComments.toString(),
                    //   onPressed: onCommentPressed!,
                    // ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onCommentPressed,
                          child: Icon(
                            Icons.mode_comment,
                            size: 35.r,
                            color:AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        CustomText(
                          text: totalComments.toString(),
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    // _buildStatRow(
                    //   icon: Icons.share,
                    //   color: AppColors.primary,
                    //   count: post!.share.toString(),
                    //   onPressed:onSharePressed!
                    // ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onLikePressed,
                          child: Icon(
                            Icons.share,
                            size: 35.r,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        CustomText(
                          text: share.toString(),
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ],
                ),

          ],
        ),
      ),
    );
  }

  // Widget _buildStatRow({
  //   required IconData icon,
  //   required Color color,
  //   required String count,
  //   required VoidCallback onPressed,
  // }) {
  //   return Row(
  //     children: [
  //       IconButton(onPressed: onPressed, icon: Icon(icon), color: color),
  //       CustomText(text: count, fontSize: 14.w, fontWeight: FontWeight.w700),
  //     ],
  //   );
  // }

/*
  /// ---------- Share Post Helper ----------
 */
/* Future<void> _sharePost() async {
    try {
      if (postImage != null && postImage!.isNotEmpty) {
        await Share.share(
            "Check out this post by $name!\n\n$caption\n\n$postImage");
      } else {
        await Share.share("Check out this post by $name!\n\n$caption");
      }
      if (post != null) {
        final socialController = Get.find<SocialController>();
        await socialController.sharePostAndCount(post!);
      }

    } catch (e) {
      debugPrint("Share Error: $e");
      Get.snackbar("Error", "Could not share post");
    }
  }*//*


  /// ---------- Share Post Helper ----------
  Future<void> _sharePost() async {
    try {
      Get.dialog(
        const Center(child: CustomLoader()),
        barrierDismissible: false,
      );

      bool didShare = false;

      // Open share sheet
      if (postImage != null && postImage!.isNotEmpty) {
        didShare = await Share.share(
          "Check out this post by $name!\n\n$caption\n\n$postImage",
        ).then((_) => true).catchError((_) => false);
      } else {
        didShare = await Share.share(
          "Check out this post by $name!\n\n$caption",
        ).then((_) => true).catchError((_) => false);
      }

      Get.back(); // Close loader

      // Only show confirm dialog if didShare == true
      if (didShare) {
        bool? confirm = await Get.dialog<bool>(
          AlertDialog(
            title: const Text("Confirm Share"),
            content: const Text("Did you actually share this post?"),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text("Yes"),
              ),
            ],
          ),
          barrierDismissible: false,
        );

        // Increment count only if user confirms
        if (confirm == true && post != null) {
          final socialController = Get.find<SocialController>();
          await socialController.sharePostAndCount(post!);
        }
      }

    } catch (e) {
      debugPrint("Share Error: $e");
      Get.back(); // close loader
      Get.snackbar("Error", "Could not share post");
    }
  }

*/




  void _showReportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
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
                const Center(child: CustomText(text: "Report")),
                const SizedBox(height: 10),
                const CustomText(text: "Why are you reporting this post?"),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                        const CustomText(text: "Spam / Irrelevant Content"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(
                            text: "Offensive / Abusive Language"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(
                            text: "Hate Speech / Discrimination"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(
                            text: "Fake / Misleading Information"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(text: "Scam / Fraud"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(
                            text: "Sexual / Inappropriate Content"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(text: "Violence / Threat"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(text: "Copyright Violation"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const CustomText(text: "Other (Custom Reason)"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => Get.toNamed(AppRoutes.reportScreen),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
  }
}



