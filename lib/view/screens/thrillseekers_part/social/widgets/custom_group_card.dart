import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomGroupCard extends StatelessWidget {
  const CustomGroupCard({super.key, this.onTap, this.groupName, this.totalMember,  this.img});

  final VoidCallback? onTap;
  final String? groupName;
  final int? totalMember;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: img != null ? '${ApiUrl.baseUrl}/${img}' : AppConstants.profileImage,
                  height: 50,
                  width: 50,
                  boxShape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                SizedBox(width: 10.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: groupName??"",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      children: [
                        Icon(Icons.supervised_user_circle),
                        CustomText(
                          text: "${totalMember ?? 0} members",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              autofocus: true,
              onPressed: onTap,
              child: CustomText(
                text: "Join",
                fontSize: 14.w,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
