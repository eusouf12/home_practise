import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../host_part/home/widgets/custom_event_container.dart';
import '../../controller/home_controller/dm_home_controller.dart';

class DmLiveEvent extends StatelessWidget {
  DmLiveEvent({super.key});
  final DmHomeController dmHomeController = Get.put(DmHomeController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dmHomeController.fetchLiveEvents();
    });
    return CustomGradient(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Live Event",),
      body:
      Obx(() {
        if (dmHomeController.rxLiveEventRequestStatus.value == Status.loading) {
          return const Center(child: CustomLoader());
        }
        if (dmHomeController.rxLiveEventRequestStatus.value == Status.error) {
          return  Center(child: Text("Failed to load Events"));
        }
        if (dmHomeController.events.isEmpty) {
          return  Center(child: Text("No live events found"));
        }

        return NotificationListener <ScrollNotification>(
            onNotification: (scrollInfo){
              if(!dmHomeController.isMoreLoading.value &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              dmHomeController.currentPage <= dmHomeController.totalPages){
                dmHomeController.fetchLiveEvents();
              }
              return true;
            },
            child:   ListView.builder(
              padding:  EdgeInsets.all(10),
              itemCount: dmHomeController.events.length + (dmHomeController.isMoreLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == dmHomeController.events.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CustomLoader()),
                  );
                }
                final event = dmHomeController.events[index];
               // debugPrint("Event length=============${dmHomeController.events.length}");
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: CustomEventContainer(
                    title: event.eventTitle ?? "",
                    date: event.date ?? "",
                    startingTime: event.startingTime ?? "",
                    img: '${ApiUrl.baseUrl}/${event.photo ?? ''}',
                    attendees: true,
                    liveButton: false,
                    pastEvent: true,
                    UpcomingEvent: true,
                    onTap: ()async{
                      await SharePrefsHelper.setString('selectedEventId', event.id);
                      await SharePrefsHelper.setString('pageName', 'liveEvent');
                      Get.toNamed(AppRoutes.dmLiveEventDetails);

                    },
                  ),
                );
              },
            ),
        );
      }),
    ));
  }
}

