import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../host_part/home/widgets/custom_event_container.dart';

class DmUpcomingEventScreen extends StatelessWidget {
  const DmUpcomingEventScreen({super.key});

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoyelAppbar(leftIcon: true, titleName: "Upcoming & Past Events",),
              Expanded(child: ListView(
                padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                children: [
                  Column(
                    children: List.generate(8, (value) {
                      return CustomEventContainer(
                        price: true,
                        liveButton: true,
                        update: false,
                        pastEvent: true,
                        UpcomingEvent: false,
                        img: AppConstants.ntrition1,
                        title: "Summer Music Festival",
                        onTap: (){
                          Get.toNamed(AppRoutes.dmUpcomingEventDetails);
                        },
                      );
                    }),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
      // bottomNavigationBar: HostNavbar(currentIndex: 0,),
    );
  }
}
