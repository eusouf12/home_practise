import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/view/screens/thrillseekers_part/favorite/view/favourite_screen/favourite_screen.dart';
import 'package:event_platform/view/screens/thrillseekers_part/home_screen/view/dm_home_screen/dm_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../screens/thrillseekers_part/message/message_screen/dm_message_screen.dart';
import '../../screens/thrillseekers_part/profile/view/profile_screen/dm_profile_screen.dart';
import '../../screens/thrillseekers_part/social/social_screen/dm_social_screen.dart';


class DmNavBar extends StatefulWidget {
  final int currentIndex;

  const DmNavBar({required this.currentIndex, super.key});

  @override
  State<DmNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<DmNavBar> {
  late int bottomNavIndex;

  final List<String> icons = [
    AppIcons.navHome,
    AppIcons.heartBold,
    AppIcons.navMessage,
    AppIcons.navGlobal,
    AppIcons.navUser,

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
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        // border: Border.all(color: AppColors.grey_03, width: .2),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey,
        //     spreadRadius: 1,
        //     blurRadius: 0,
        //     offset: const Offset(3, 0),
        //   ),
        // ],
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
                        : Color(0xFFD2D2D2),
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
          Get.offAll(() => DmMessageScreen());
          break;
        case 3:
          Get.offAll(() => DmSocialScreen());
          break;
        case 4:
          Get.to(() => DmProfileScreen());
          break;
      }
    }
  }
}