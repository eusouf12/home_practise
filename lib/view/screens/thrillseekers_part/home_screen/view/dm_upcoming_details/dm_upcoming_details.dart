import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../host_part/home/controller/home_controller.dart';
import '../../../profile/controller/dm_profile_controller.dart';
import '../../controller/home_controller/dm_home_controller.dart';
import '../../widget/custom_ticket_count/custom_ticket_count.dart';
import '../../widget/custom_upcoming_time_count/custom_countdown_timer.dart';
import '../../widget/middle_details/middle_details.dart';

class DmUpcomingDetails extends StatelessWidget {
  DmUpcomingDetails({super.key});
  final DmHomeController dmHomeController = Get.put(DmHomeController());
  final DmProfileController dmProfileController = Get.put(DmProfileController());
  final CounterController counterController = Get.put(CounterController());
  final homeController = Get.find<HomeController>();


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      dmHomeController.getLiveEventDetails();
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomRoyelAppbar(leftIcon: true, titleName: "Details Page",),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx((){
            if (dmHomeController.rxLiveEventRequestStatus.value == Status.loading) {
              return const Center(child: CustomLoader());
            }
            if (dmHomeController.rxLiveEventRequestStatus.value == Status.error) {
              return  Center(child: Text("Failed to load Events Details"));
            }
            if (dmHomeController.specificEvent.value ==  null) {
              return  Center(child: Text("No live events details found"));
            }
            final event = dmHomeController.specificEvent.value!;
            final eventLocation = dmHomeController.specificEvent.value?.audienceSettings?.eventLocation;
            final ticketType = dmHomeController.specificEvent.value?.audienceSettings?.ticketPrice;
            if (eventLocation != null) {
               homeController.getPlaceNameFromCoordinates(
                eventLocation.lat ?? "",
                eventLocation.lon ?? "",
              );
            }
            return   Column(
              children: [
                 SizedBox(height: 20),
                Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomNetworkImage(
                        imageUrl:'${ApiUrl.baseUrl}/${event.photo }',
                        height: 160.h,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        width: MediaQuery.sizeOf(context).width,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 14.5, vertical: 20,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //event title
                            Row(
                              children: [
                                Expanded(child: CustomText(
                                     text: event.eventTitle??" ",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    bottom: 4,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                  ),),
                                EventCountdown(event: event,),
                              ],
                            ),
                            //event description
                            CustomText(
                              text:event.description??" ",
                              maxLines: 10,
                              textAlign: TextAlign.start,
                              bottom: 8,
                              top: 3,
                            ),
                             SizedBox(height: 8),
                            // joined+Invited+18+
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.invitedScreen);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.r,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.red_02,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.group_add,
                                          color: AppColors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        const CustomText(
                                          text: 'Invite',
                                          color: AppColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.venueFacility,
                                        arguments: event.venueFacilities);
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 121,
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: 'Venue Facility',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:  Center(
                                      child: CustomText(
                                        text: event.audienceSettings?.age ??"",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                             SizedBox(height: 21),
                            // middle
                            MiddleDetails(
                              title: event.eventTitle??" ",
                              location: homeController.placeName.value,
                              date: "${event.date != null ? DateFormat('dd-MM-yyyy').format(event.date!) : ''} - ${event.startingTime}",
                            ),

                            const SizedBox(height: 16),

                            ticketType == "paid"
                                ? Column(
                              children: [
                                Divider(thickness: 1, color: AppColors.primary),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Quantity",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primary,
                                    ),
                                    Spacer(),
                                    Obx(() => CustomTimeCount(
                                      value: counterController.counter.value,
                                      onIncrement: counterController.increment,
                                      onDecrement: counterController.decrement,
                                    )),
                                  ],
                                ),
                              ],
                            )
                                : const SizedBox.shrink(),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                //btn
                ticketType == "paid"
                    ? Column(
                  children: [
                    CustomButton(
                      onTap: () {
                        int total = counterController.counter.value;
                        SharePrefsHelper.setInt('totalTicket', total);
                        Get.toNamed(AppRoutes.confirmBooking);
                      },
                      height: 70,
                      fillColor: AppColors.primary,
                      title: "Book a ticket",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 77),
                  ],
                )
                    : const SizedBox.shrink(),

              ],
            );
          }),
        ),
      ),
    );
  }
}