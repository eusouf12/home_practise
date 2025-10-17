import 'package:event_platform/service/api_url.dart';
import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../controller/favourite_controller.dart';
import '../../widget/custom_gallery_card/custom_gallery_card.dart';

class GalleryScreen extends StatelessWidget {
  final FavouriteController controller = Get.put(FavouriteController());
     GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getMyMemories();
    });

    final String eventId = Get.arguments;


    Widget selectedTabButton(String tabName, int index) {
      return Obx(() => GestureDetector(
        onTap: (){
          controller.changeTab(index);
        } ,

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: controller.selectedTabIndex.value == index
                ? AppColors.primary
                : const Color(0xFFE1FFF8),
          ),
          child: Center(
            child: CustomText(
              text: tabName,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: controller.selectedTabIndex.value == index
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ),
      ));
    }

    return CustomGradient(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar:
          const CustomRoyelAppbar(leftIcon: true, titleName: "Gallery"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 42),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const CustomText(
                    text: 'Share Your Event \n Experience',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    textAlign: TextAlign.center,
                  ),

                  // Upload button
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.uploadScreen, arguments: eventId);
                        debugPrint("Event ID: $eventId");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(53),
                          color: AppColors.primary,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file, color: AppColors.white),
                            CustomText(
                              text: 'Upload Photos / Videos',
                              left: 5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Category section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Category',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),

                      // Tabs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          controller.tabNames.length,
                              (index) => selectedTabButton(controller.tabNames[index], index),
                        ),
                      ),

                      SizedBox(height: 20.h),


                      Obx(() {
                        if (controller.isLoadingMemories.value && controller.myMemoriesList.isEmpty) {
                          return const Center(child: CustomLoader());
                        }

                        if (controller.myMemoriesList.isEmpty) {
                          return const Center(child: Text("No items found."));
                        }

                        return SizedBox(
                          height: 400.h,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (!controller.isMoreMemoriesLoading.value &&
                                  scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                controller.getMyMemories(contentType: controller.currentFilter);
                                return true;
                              }
                              return false;
                            },
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.myMemoriesList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == controller.myMemoriesList.length) {
                                  return controller.isMoreMemoriesLoading.value
                                      ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(child: CustomLoader()),
                                  )
                                      : const SizedBox.shrink();
                                }

                                final item = controller.myMemoriesList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Obx(() => CustomGalleryCard(
                                    isFavourite: item.isFavorite.toString(),
                                    img: "${ApiUrl.baseUrl}/${item.content}",
                                    title: item.description,
                                    isLove: item.isLove.value, // reactive value
                                    onLoveTap: () {
                                      // toggle locally first
                                      item.isLove.value = !item.isLove.value;
                                      debugPrint("Love button clicked: ${item.isLove.value}");
                                      // then call API
                                      controller.loveCount(favoriteEventId: item.id, isLove: item.isLove.value,currentPage: controller.currentPageMemories - 1, );
                                    },
                                  )),

                                );
                              },
                            ),
                          ),
                        );
                      })



                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
