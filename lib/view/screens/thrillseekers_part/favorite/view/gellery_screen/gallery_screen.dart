import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../widget/custom_gallery_card/custom_gallery_card.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String selectedTab = 'All'; 

  List<Map<String, String>> galleryItems = [
    {'type': 'Photo', 'title': 'Event Photo 1', 'image': AppConstants.ntrition},
    {'type': 'Photo', 'title': 'Event Video 1', 'image': AppConstants.ntrition},
    {'type': 'Photo', 'title': 'Event Photo 2', 'image': AppConstants.ntrition},
    {'type': 'Photo', 'title': 'Event Video 2', 'image': AppConstants.ntrition},
    {'type': 'Photo', 'title': 'Event Photo 3', 'image': AppConstants.ntrition},
    {'type': 'Video', 'title': 'Event Video 3', 'image': AppConstants.ntrition},
  ];


  List<Map<String, String>> getFilteredItems() {
    if (selectedTab == 'All') {
      return galleryItems;
    } else {
      return galleryItems.where((item) => item['type'] == selectedTab).toList();
    }
  }


  Widget selectedTabButton(String tabName, double width) {
    bool isSelected = selectedTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabName;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? AppColors.primary : Color(0xFFE1FFF8),

        ),
        child: Center(
          child: CustomText(
            text: tabName,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = getFilteredItems();

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Gallery"),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 25, left: 20, right: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 42),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: 'Share Your Event \n Experience',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(53),
                          color: AppColors.primary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Icon(Icons.upload_file, color: AppColors.white,),
                          CustomText(
                            text: 'Upload Photos / Videos',
                            left: 5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Category',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          selectedTabButton('All', 90),
                          SizedBox(width: 10),
                          selectedTabButton('Photo', 90),
                          SizedBox(width: 10),
                          selectedTabButton('Video', 100),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        children: filteredItems.map((item) {
                          return CustomGalleryCard(
                            img: item['image'],
                            title: item['title'],
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}