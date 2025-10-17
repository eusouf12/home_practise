import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/dm_social_controller.dart';
import '../widgets/custom_event_tabbar.dart';
import '../widgets/custom_group_card.dart';
import '../widgets/custom_post.dart';
import '../widgets/custom_story.dart';

class DmSocialScreen extends StatefulWidget {
  const DmSocialScreen({super.key});

  @override
  State<DmSocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<DmSocialScreen> {
  final dmSocialController = Get.find<DmSocialController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const CustomRoyelAppbar(
                  leftIcon: false,
                  titleName: "Social Feed",
                ),
                CustomEventTabbar(
                  textColor: AppColors.white,
                  tabs: dmSocialController.tabNamelist,
                  selectedIndex: dmSocialController.currentIndex.value,
                  onTabSelected: (value) {
                    dmSocialController.currentIndex.value = value;
                    setState(() {});
                  },
                  selectedColor: AppColors.primary,
                ),

                if (dmSocialController.currentIndex.value == 0)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes.createStoryScreen);
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          CustomNetworkImage(
                                            imageUrl: AppConstants.profileImage,
                                            height: 60.h,
                                            width: 60.w,
                                            boxShape: BoxShape.circle,
                                          ),
                                          const Positioned(
                                            right: -4,
                                            bottom: -10,
                                            child: CircleAvatar(
                                              backgroundColor: AppColors.white,
                                              radius: 14,
                                              child: Icon(Icons.add,
                                                  color: AppColors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    CustomText(
                                      top: 12.h,
                                      text: "Your Story",
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: CustomStory(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                         /* Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Profile Image
                                Flexible(
                                  flex: 1,
                                  child: CustomNetworkImage(
                                    imageUrl: AppConstants.profileImage,
                                    height: 50,
                                    width: 50,
                                    boxShape: BoxShape.circle,
                                  ),
                                ),

                                /// TextField
                                Flexible(
                                  flex: 5,
                                  child: CustomTextField(
                                    fillColor: Colors.transparent,
                                    fieldBorderRadius: 30,
                                    hintText: "Create post?",
                                    readOnly: true,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.createPostScreen);
                                    },
                                    hintStyle: const TextStyle(
                                        color: Color(0xff404040)),
                                  ),
                                ),

                                /// Icon
                                Flexible(
                                  flex: 1,
                                  child: Icon(Icons.image,
                                      color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: .1,
                            color: AppColors.primary,
                          ),*/

                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return CustomPost(
                                onTap2: (){
                                  Get.toNamed(AppRoutes.personProfileScreen);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),

                if (dmSocialController.currentIndex.value == 1)
                  Expanded(
                      child: ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    //  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return CustomGroupCard(
                      );
                    },
                  )),
                if (dmSocialController.currentIndex.value == 2)
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Summer Music Festival",
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text: "156  participants",
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            Container(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                              decoration: BoxDecoration(
                                color: Color(0xffDCFCE7),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                  child: CustomText(
                                text: "Chat",
                                fontSize: 14.w,
                                fontWeight: FontWeight.w500,
                              )),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: DmNavBar(currentIndex: 3,),
    );
  }
}

