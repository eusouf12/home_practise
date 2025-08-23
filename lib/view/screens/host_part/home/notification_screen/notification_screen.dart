import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/screens/host_part/home/notification_screen/widget/custom_notifi_list.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
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
            children: [
              CustomRoyelAppbar(
                leftIcon: true,
                titleName: AppStrings.notification,
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        title:
                            'Sunset Cinema announced Outdoor Movie Night this Friday ',
                        subtitle: "Free Entry + Popcorn!",
                        time: "3h",
                      );
                    },
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
