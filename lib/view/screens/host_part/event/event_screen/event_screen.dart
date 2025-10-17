import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_loader/custom_loader.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../../home/widgets/custom_event_container.dart';
import '../controller/event_controller.dart';
import '../widgets/custom_event_tabbar.dart';
import '../widgets/event_point_card.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.find<EventController>();

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
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
                    onTap: () {
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
              SizedBox(height: 20.h),

              ///============= Tab Bar =================
              Obx(() => CustomEventTabbar(
                textColor: AppColors.white,
                tabs: eventController.tabNames,
                selectedIndex: eventController.currentIndex.value,
                onTabSelected: (value) {
                  eventController.onTabSelected(value);
                },
                selectedColor: AppColors.primary,
              )),
              SizedBox(height: 10.h),

              ///============= Event Stats =================
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EventPointCard(
                      point: eventController.isLoading.value &&
                          eventController.totalEvents.value == 0
                          ? "..."
                          : eventController.totalEvents.value.toString(),
                      title: "Events",
                    ),
                    const EventPointCard(
                      point: "315",
                      title: "Total\nAttendance",
                    ),
                    const EventPointCard(
                      point: "5.1",
                      title: "Ratings",
                    ),
                  ],
                )),
              ),

              ///============= Event List =================
              Expanded(
                child: Obx(() {
                  if (eventController.isLoading.value && eventController.events.isEmpty) {
                    return const Center( child: CustomLoader() );
                  }

                  if (eventController.events.isEmpty ) {
                    return Center(
                      child: CustomText(
                        text:
                        "No events found for '${eventController.tabNames[eventController.currentIndex.value]}'.",
                        color: AppColors.primary,
                        fontSize: 16.sp,
                      ),
                    );
                  }


                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!eventController.isMoreLoading.value &&
                          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                          eventController.currentPage <= eventController.totalPages) {
                        eventController.fetchEvents(
                          eventController.tabNames[eventController.currentIndex.value],
                        );
                      }
                      return true;
                    },

                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20.h),
                      itemCount: eventController.events.length + (eventController.isMoreLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == eventController.events.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CustomLoader()),
                          );
                        }

                        final event = eventController.events[index];
                        VoidCallback? onTapUpdateAction;
                        int currentTab = eventController.currentIndex.value;
                        DateFormat dateFormat = DateFormat("dd-MM-yyyy hh:mm a");
                        String normalizeTime(String time) {
                          // example: "10:30 pm" → "10:30 PM"
                          return time.trim().toUpperCase();
                        }
                        final eventDate = event.date ?? "";
                        final startTime = normalizeTime(event.startingTime ?? "");
                        final endTime = normalizeTime(event.endingTime ?? "");

                        final eventStart = dateFormat.parse("$eventDate $startTime");
                        final eventEnd = dateFormat.parse("$eventDate $endTime");
                        final now = DateTime.now();
                        if (currentTab == 0) {
                          return CustomEventContainer(
                            title: event.eventTitle,
                            date: event.date,
                            startingTime: event.startingTime,
                            img: '${ApiUrl.baseUrl}/${event.photo}',
                            onTapUpdate: onTapUpdateAction,
                            liveButton: now.isAfter(eventStart) && now.isBefore(eventEnd) ? false : true,
                            pastEvent: now.isAfter(eventEnd) ? false : true,
                            UpcomingEvent: now.isBefore(eventStart) ? false : true,
                            attendees: now.isAfter(eventEnd) || now.isAfter(eventStart) && now.isBefore(eventEnd) ? true : false,
                            rating:  now.isAfter(eventEnd) ? true : false,
                            price: now.isBefore(eventStart) ? true : false,
                          );
                        }
                        else if (currentTab == 1) {
                          return CustomEventContainer(
                            title: event.eventTitle,
                            date: event.date,
                            startingTime: event.startingTime,
                            img: '${ApiUrl.baseUrl}/${event.photo}',
                            attendees: true,
                            liveButton: false,
                            pastEvent: true,
                            UpcomingEvent: true,
                          );
                        }
                        else if (currentTab == 2) {
                          return CustomEventContainer(
                            title: event.eventTitle,
                            date: event.date,
                            startingTime: event.startingTime,
                            img: '${ApiUrl.baseUrl}/${event.photo}',
                            pastEvent: true,
                            UpcomingEvent: false,
                            liveButton: true,
                            price: true,
                            update: true,
                            onTapUpdate: (){
                              Get.toNamed(AppRoutes.hostUpdateScreen,
                                arguments: {"eventId": event.id,}
                              );
                            },
                          );
                        }
                        else if (currentTab == 3) {
                          return CustomEventContainer(
                            title: event.eventTitle,
                            date: event.date,
                            startingTime: event.startingTime,
                            img: '${ApiUrl.baseUrl}/${event.photo}',
                            onTapUpdate: onTapUpdateAction,
                            attendees: true,
                            rating: true,
                            liveButton: true,
                            pastEvent: false,
                            UpcomingEvent: true,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),


                  );
                }),
              )
            ],
          ),
        ),
        bottomNavigationBar: HostNavbar(currentIndex: 1),
      ),
    );
  }
}