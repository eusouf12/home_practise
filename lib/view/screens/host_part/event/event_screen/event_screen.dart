import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../../home/widgets/custom_event_container.dart';
import '../controller/event_controller.dart';
import '../widgets/custom_event_tabbar.dart';
import '../widgets/event_point_card.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
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
                  CustomText(
                    text: AppStrings.myEvent,
                    fontSize: 24.w,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.createScreen);
                    },
                    child: CircleAvatar(
                      radius: 26.r,
                      backgroundColor: Colors.white,
                      child: CustomImage(
                        imageSrc: AppIcons.plusSquare,
                        imageColor: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              ///============= Tab Bar =================
              CustomEventTabbar(
                textColor: AppColors.white,
                tabs: eventController.tabNamelist,
                selectedIndex: eventController.currentIndex.value,
                onTabSelected: (value) {
                  eventController.currentIndex.value = value;
                  setState(() {});
                },
                selectedColor: AppColors.primary,
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EventPointCard(
                    point: "3",
                    title: "Events",
                  ),
                  EventPointCard(
                    point: "315",
                    title: "Total\nAttendance",
                  ),
                  EventPointCard(
                    point: "5.1",
                    title: "Ratings",
                  ),
                ],
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.only(top: 20.h),
                children: [
                 if (eventController.currentIndex.value == 0) Column(
                    children: List.generate(2, (value) {
                      return CustomEventContainer(
                        img: AppConstants.ntrition1,
                        update: true,
                        liveButton: true,
                        pastEvent: true,
                        price: true,
                        title: "Summer Music Festival",
                        onTap: () {
                          Get.toNamed(AppRoutes.hostLiveEventDetails);
                        },
                      );
                    }
                    ),
                  ),

                  if (eventController.currentIndex.value == 1) Column(
                    children: List.generate(1, (value) {
                      return CustomEventContainer(
                        img: AppConstants.ntrition1,
                        update: false,
                        price: false,
                        liveButton: false,
                        UpcomingEvent: true,
                        pastEvent: true,
                        title: "Summer Music Festival",
                        onTap: () {
                           Get.toNamed(AppRoutes.hostLiveEventDetails);
                        },
                      );
                    }
                    ),
                  ),
                  if (eventController.currentIndex.value == 2) Column(
                    children: List.generate(2, (value) {
                      return CustomEventContainer(
                        img: AppConstants.ntrition1,
                        update: false,
                        price: false,
                        pastEvent: true,
                        UpcomingEvent: false,
                        liveButton: true,
                        title: "Summer Music Festival",
                        onTap: () {
                          Get.toNamed(AppRoutes.hostLiveEventDetails);
                        },
                      );
                    }
                    ),
                  ),
                  if (eventController.currentIndex.value == 3) Column(
                    children: List.generate(1, (value) {
                      return CustomEventContainer(
                        img: AppConstants.ntrition1,
                        update: false,
                        price: false,
                        pastEvent: false,
                        UpcomingEvent: true,
                        liveButton: true,
                        title: "Summer Music Festival",
                        onTap: () {
                          Get.toNamed(AppRoutes.hostLiveEventDetails);
                        },
                      );
                    }
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),




                ],
              ))
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: HostNavbar(
            currentIndex: 1,
          ),
        )
      ]),
    );
  }
}
