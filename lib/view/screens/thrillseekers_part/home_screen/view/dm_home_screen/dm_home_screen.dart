import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_loader/custom_loader.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/screens/thrillseekers_part/profile/controller/dm_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../controller/home_controller/dm_home_controller.dart';

class DmHomeScreen extends StatelessWidget {
  DmHomeScreen({super.key});
  final DmHomeController dmHomeController = Get.put(DmHomeController());
  final DmProfileController dmProfileController = Get.put(DmProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dmProfileController.getUserProfile();
      dmHomeController.getLocationUpdates();
      dmHomeController.initializeCustomMarkers();
    });
    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour > 4 && hour < 12) {
        return "Good Morning";
      } else if (hour > 11 && hour < 17) {
        return "Good Afternoon";
      }else if (hour > 16 && hour < 22) {
        return "Good Evening";
      } else {
        return "Good Night";
      }
    }

    return CustomGradient(
      child:
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // appbar profile info
                Expanded(
                  child: Obx(() => Row(
                    children: [
                      ClipOval(
                        child:CustomNetworkImage(
                          imageUrl:dmProfileController.userProfileModel.value.photo != null?"${ApiUrl.baseUrl}/${dmProfileController.userProfileModel.value.photo}" : AppConstants.profileImage,
                          height: 50.h,
                          width: 50.w,
                          boxShape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: getGreeting(),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          CustomText(
                            text: dmProfileController.userProfileModel.value.name ?? "",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  )),
                ),

                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF7FFEF),
                    ),
                    child: CustomImage(imageSrc: AppIcons.notification),
                  ),
                ),
              ],
            ),

        ),

        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10, bottom: 26.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Find Best Events\nNear You',
                textAlign: TextAlign.left,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 16),

              CustomTextField(
                hintText: 'Explore events',
                hintStyle: TextStyle(color: AppColors.black_80),
                fieldBorderRadius: 15,
                fieldBorderColor: AppColors.white,
                fillColor: AppColors.white,
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.dmFilter);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.menu_rounded,size: 18,),
                            CustomText(text: "Event Filters",fontSize: 18,fontWeight: FontWeight.w400,),
                            Icon(Icons.keyboard_arrow_down_outlined,size: 18,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.barRestaurants);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 30),
                            CustomText(text: "Non-Events",fontSize: 18,fontWeight: FontWeight.w400,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Obx(() => RichText(
                text: TextSpan(
                  text: 'Find events near. ',
                  style: TextStyle(color: AppColors.black, fontSize: 16.w, fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text: dmHomeController.currentAddress.value,
                      style: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    WidgetSpan(child: Icon(Icons.location_on_outlined)),
                  ],
                ),
              )),
              // live & upcoming btn
              Row(
                children: [
                  Icon(Icons.circle, size:15, color: Color(0xFF53CCB1)),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmLiveScreen);
                    },
                    child: CustomText(
                      text: "Live Event",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black_80,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.circle, size: 15, color:Color(0xFF849084) ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.dmUpcomingEventScreen);
                    },
                    child: CustomText(
                      text: "Up Coming Live",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black_80,
                    ),
                  ),
                ],
              ),
              //map show
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Obx(() => dmHomeController.currentPosition.value == null
                      ? const Center(child: CustomLoader())
                      :
                  GoogleMap(
                    onMapCreated: (map) => dmHomeController.mapController = map,
                    initialCameraPosition: CameraPosition(
                      target: DmHomeController.nearByLocation,
                      zoom: 10,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("_currentLocation"),
                        position: dmHomeController.currentPosition.value!,
                        icon: dmHomeController.currentLocationIcon ?? BitmapDescriptor.defaultMarker,
                      ),
                      Marker(
                        markerId: MarkerId("_sourceLocation"),
                        position: DmHomeController.far,
                        icon: dmHomeController.farLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
                      ),
                      Marker(
                        markerId: MarkerId("_destinationLocation"),
                        position: DmHomeController.nearByLocation,
                        icon: dmHomeController.nearByLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                      ),
                    },
                  )),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DmNavBar(currentIndex: 0),
      ),
    );
  }
}