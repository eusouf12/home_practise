import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../host_part/home/widgets/custom_event_container.dart';
import '../../controller/home_controller/dm_home_controller.dart';

class DmUpcomingEventScreen extends StatelessWidget {
   DmUpcomingEventScreen({super.key});
   final DmHomeController dmHomeController = Get.put(DmHomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dmHomeController.fetchUpcomingEvents();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Upcoming & Past Events",),
        body: Obx(() {
          if (dmHomeController.rxUpcomingEventRequestStatus.value == Status.loading) {
            return const Center(child: CustomLoader());
          }
          if (dmHomeController.rxUpcomingEventRequestStatus.value == Status.error) {
            return  Center(child: Text("Failed to load Events"));
          }
          if (dmHomeController.upcomingEvents.isEmpty) {
            return  Center(child: Text("No Upcoming and Past events found"));
          }

          return NotificationListener <ScrollNotification>(
            onNotification: (scrollInfo){
              if(!dmHomeController.isMoreLoading.value &&
                  scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  dmHomeController.currentPage <= dmHomeController.totalPages){
                dmHomeController.fetchUpcomingEvents();
              }
              return true;
            },
            child:   ListView.builder(
              padding:  EdgeInsets.all(10),
              itemCount: dmHomeController.upcomingEvents.length + (dmHomeController.isMoreLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == dmHomeController.upcomingEvents.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CustomLoader()),
                  );
                }
                final upcomingEvents = dmHomeController.upcomingEvents[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: CustomEventContainer(
                    title: upcomingEvents.eventTitle ?? "",
                    date: upcomingEvents.date ?? "",
                    startingTime: upcomingEvents.startingTime ?? "",
                    img: '${ApiUrl.baseUrl}/${upcomingEvents.photo }??AppConstants.profileImage',
                    attendees: upcomingEvents.type == "past"? true:false,
                    price: upcomingEvents.type != "past"? true:false,
                    ticketPrice: upcomingEvents.price,
                    ticketType: upcomingEvents.ticket_Price,
                    liveButton: true,
                    pastEvent: upcomingEvents.type == "past"? false:true,
                    UpcomingEvent: upcomingEvents.type != "past"?false:true,
                    onTap: () async {
                      // Check if event type is NOT "past"
                      if (upcomingEvents.type != "past") {
                        await SharePrefsHelper.setString('selectedEventId', upcomingEvents.id);
                        String savedId = await SharePrefsHelper.getString('selectedEventId');
                        print("Selected Event ID from SharedPrefs: $savedId");
                        Get.toNamed(AppRoutes.dmUpcomingEventDetails);
                      }

                    },

                  ),
                );
              },
            ),
          );
        }),

      ),);
  }
}
