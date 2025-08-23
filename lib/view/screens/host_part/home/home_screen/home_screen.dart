import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../widgets/custom_event_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     children: [
                       CustomNetworkImage(
                           imageUrl: AppConstants.profileImage,
                           boxShape: BoxShape.circle,
                           height: 60.h,
                           width: 60.w),
                       SizedBox(width: 10.w,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           CustomText(text: "Hello, Mehedi", fontSize: 16.w,fontWeight: FontWeight.w500,),
                           CustomText(text: "Event Host", fontSize: 12.w,fontWeight: FontWeight.w300,),
                         ],
                       ),
                     ],
                   ),
                    GestureDetector(
                      onTap: (){
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
                CustomButton(onTap: (){
                  Get.toNamed(AppRoutes.createScreen);
                },
                  showSocialButton: true,
                  imageSrc: AppIcons.plusSquare,
                  title: AppStrings.createEvent,
                ),
                Expanded(child: ListView(
                  padding: EdgeInsets.only(top: 20.h),
                  children: [
                    Column(
                      children: List.generate(8, (value) {
                        return CustomEventContainer(
                          price: false,
                          liveButton: true,
                          update: false,
                          pastEvent: true,
                          img: AppConstants.ntrition1,
                          title: "Summer Music Festival",
                          onTap: (){
                           // Get.toNamed(AppRoutes.groupEventScreen);
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 80.h,)
                  ],
                ))
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HostNavbar(currentIndex: 0,),)
        ],
      ),
     // bottomNavigationBar: HostNavbar(currentIndex: 0,),
    );
  }
}
