import 'package:event_platform/utils/app_images/app_images.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../widget/custom_2nd_hintext_field/custom_2nd_hintext_field.dart';
import '../../widget/custom_bar_card/custom_bar_card.dart';

class BarResturentScreen extends StatefulWidget {
  const BarResturentScreen({super.key});

  @override
  State<BarResturentScreen> createState() => _BarResturentScreenState();
}

class _BarResturentScreenState extends State<BarResturentScreen> {
  final FocusNode searchBox = FocusNode();
  int selectedTab = 0;

  @override
  void dispose() {
    searchBox.dispose();
    super.dispose();
  }

  void _focusSearchBox() {
    FocusScope.of(context).requestFocus(searchBox);
  }

  void selectTab(int tabIndex) {
    setState(() {
      selectedTab = tabIndex;
    });
    FocusScope.of(context).unfocus();
  }

  Widget selectedTabButton(String text, int index) {
    final bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => selectTab(index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
          child: CustomText(
            text: text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildOthersButton() {
    final bool isSelected = selectedTab == 2;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = 2;
        });
        _focusSearchBox();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
          child: CustomText(
            text: "Others",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 24, left: 20, right: 20, bottom: 16),
                  child: Custom2ndHintTextField(
                    prefixIcon: Icon(Icons.search, color: AppColors.primary),
                    firstHint: (selectedTab == 0) ? "Bar" : "Restaurant",
                    secondHint: (selectedTab == 0)
                        ? "Italiano by Pucchini"
                        : "Lord of the Wings",
                    focusNode: searchBox,
                    firstHintColor: AppColors.black,
                    secondHintColor: AppColors.black_02,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  child: Row(
                    children: [
                      selectedTabButton("Bars", 0),
                      const SizedBox(width: 10),
                      selectedTabButton("Restaurants", 1),
                      const SizedBox(width: 10),
                      _buildOthersButton(),
                    ],
                  ),
                ),
                // Full responsive image
                CustomImage(
                  imageSrc: AppImages.map2,
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.3, // Adjusted to be responsive
                  boxFit: BoxFit.cover, // Ensures the image fills the container
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 0, top: 17, bottom: 19),
          height: 290.h,
          decoration: BoxDecoration(
            color: AppColors.primary4,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Nearby",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedTab == 0
                            ? Get.toNamed(AppRoutes.bar)
                            : Get.toNamed(AppRoutes.restaurants);
                      },
                      child: CustomText(
                        text: "See All",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              // Bar or Restaurant Cards
              Flexible(
                child: selectedTab == 0
                    ? // Bar Cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0),
                        child: SizedBox(
                          width: 300,
                          child: CustomBarCard(
                            img: AppConstants.ntrition,
                            distance: 0.5,
                            isFavorite: true,
                            title: "Sky High",
                            onShareTap: () => Get.toNamed(
                                AppRoutes.favouriteScreen),
                            onViewDetails: () => Get.toNamed(
                                AppRoutes.barDetailsPage),
                            onFavoriteTap: () {},
                          ),
                        ),
                      );
                    }),
                  ),
                )
                    : // Restaurant Cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0),
                        child: SizedBox(
                          width: 300,
                          child: CustomBarCard(
                            title: "Pie in the Sky",
                            imgName: "Restaurant",
                            img: AppConstants.ntrition,
                            onShareTap: () => Get.toNamed(
                                AppRoutes.favouriteScreen),
                            onViewDetails: () => Get.toNamed(
                                AppRoutes.barDetailsPage),
                            onFavoriteTap: () => Get.toNamed(
                                AppRoutes.favouriteScreen),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}