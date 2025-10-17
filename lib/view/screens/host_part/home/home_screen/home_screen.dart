import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:event_platform/view/screens/host_part/home/controller/home_controller.dart';
import 'package:event_platform/view/screens/host_part/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../widgets/custom_event_container.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

 final ProfileController profileController = Get.put(ProfileController());
 final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {


    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getUserProfile();
      homeController.getAllHostEvent(isRefresh: true);
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() {
          if (profileController.rxRequestStatus.value == Status.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Center(child: CustomLoader()),
            );
          }

          if (profileController.rxRequestStatus.value == Status.error) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(child: Text("Failed to load profile")),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: profileController
                              .userProfileModel.value.photo.isNotEmpty
                              ? Image.network(ApiUrl.baseUrl + "/" +
                              profileController.userProfileModel.value.photo,
                            fit: BoxFit.cover,
                            height: 60.h,
                            width: 60.w,
                          )
                              : CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 60.h,
                            width: 60.w,
                            boxShape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Hello, ${profileController.userProfileModel
                                  .value.name}",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,),
                            CustomText(text: "Event Host"),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.notificationScreen);
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: CustomImage(
                          imageSrc: AppIcons.notification,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomButton(onTap: () {
                    Get.toNamed(AppRoutes.createScreen);
                  },
                    showSocialButton: true,
                    imageSrc: AppIcons.plusSquare,
                    title: AppStrings.createEvent,
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (homeController.isLoading.value && homeController.events.isEmpty) {
                      // Initial loader
                      return const Center(child: CustomLoader());
                    }

                    if (homeController.events.isEmpty && !homeController.isLoading.value) {
                      // No events
                      return Center(
                        child: CustomText(
                          text: "No events found",
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      );
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!homeController.isMoreLoading.value &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            homeController.currentPage <= homeController.totalPages) {
                          // Load next page
                          homeController.getAllHostEvent();
                        }
                        return true;
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 20.h, bottom: 80.h),
                        itemCount: homeController.events.length +
                            (homeController.isMoreLoading.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < homeController.events.length) {
                            final event = homeController.events[index];
                            return CustomEventContainer(
                              title: event.eventTitle ?? '',
                              date: event.date ?? '',
                              startingTime: event.startingTime ?? '',
                              img: '${ApiUrl.baseUrl}/${event.photo}',
                              liveButton: true,
                              pastEvent: true,
                              price: true,
                              onTap: () {
                                // Navigate to event details
                              },
                            );
                          } else {
                            // Show bottom loader when fetching next page
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(child: CustomLoader()),
                            );
                          }
                        },
                      ),
                    );
                  }),
                ),

              ],
            ),
          );
        }),
      
        bottomNavigationBar: HostNavbar(currentIndex: 0,),
      ),
    );
  }
}
