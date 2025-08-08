import 'package:event_management/utils/app_colors/app_colors.dart';
import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/view/screen/profile_role/profile_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DmNavBar extends StatefulWidget {
  final int currentIndex;

  const DmNavBar({required this.currentIndex, super.key});

  @override
  State<DmNavBar> createState() => _DmNavBarState();
}

class _DmNavBarState extends State<DmNavBar> {
  late int bottomNavIndex;

  final List<String> selectedIcon = [
    AppIcons.home2,
    AppIcons.home2,
    AppIcons.home2,
    AppIcons.heart,
    AppIcons.home2,
  ];
  final List<String> unselectedIcon = [
    AppIcons.home2,
    AppIcons.home2,
    AppIcons.home2,
    AppIcons.heart,
    AppIcons.home2,
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
          border: Border.all(color: AppColors.grey_03,width: .2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 0,
              offset: const Offset(3, 0),
            ),
          ]
      ),
      height: 85.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          selectedIcon.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 13.h,),
                Container(
                  height: 40.h,
                  width: 40.w,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    index == bottomNavIndex ? selectedIcon[index] : unselectedIcon[index],
                    height: 24.h,
                    width: 24.w,
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
          Get.offAll(() => ProfileRoleScreen());
          break;
        case 1:
          Get.to(() => ProfileRoleScreen());
          break;
        case 2:
          Get.to(() => ProfileRoleScreen());
          break;
        case 3:
          Get.to(() => ProfileRoleScreen());
          break;
        case 4:
          Get.to(() => ProfileRoleScreen());
          break;
      }
    }
  }
}



