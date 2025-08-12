import 'package:event_management/view/screen/dmOver/favorite/view/favourite_screen/favourite_screen.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_home_screen/dm_home_screen.dart';
import 'package:event_management/view/screen/dmOver/message/view/message_screen/messege_screen.dart';
import 'package:event_management/view/screen/dmOver/profile/view/profile_screen/profile_screen.dart';
import 'package:event_management/view/screen/dmOver/social/view/social_media/social_media_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';

class DmNavBar extends StatefulWidget {
  final int currentIndex;

  const DmNavBar({required this.currentIndex, super.key});

  @override
  State<DmNavBar> createState() => _DmNavBarState();
}

class _DmNavBarState extends State<DmNavBar> {
  late int bottomNavIndex;

  final List<String> icons = [
    AppIcons.home2,
    AppIcons.heart,
    AppIcons.comment,
    AppIcons.group,
    AppIcons.user,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.green_01,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),

      ),
      height: 85.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          icons.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 13.h),
                Container(
                  height: 47.62.h,
                  width: 47.62.w,
                  decoration: BoxDecoration(
                    color: index == bottomNavIndex
                        ? Colors.white
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    icons[index],
                    height: 25.h,
                    width: 25.w,
                    // ignore: deprecated_member_use
                    color: index == bottomNavIndex
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index != bottomNavIndex) {
      setState(() {
        bottomNavIndex = index;
      });

      switch (index) {
        case 0:
          Get.offAll(() => DmHomeScreen());
          break;
        case 1:
          Get.offAll(() => FavouriteScreen());
          break;
        case 2:
          Get.offAll(() => MessageScreen());
          break;
        case 3:
          Get.offAll(() => SocialMediaScreen());
          break;
        case 4:
          Get.to(() => ProfileScreen());
          break;
      }
    }
  }
}
