import 'package:event_management/utils/app_images/app_images.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/notification_card/notification_card.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_text/custom_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                // child: Container(
                //   height: 38.5,
                //   width: 38.5,
                //   decoration: BoxDecoration(
                //     color: AppColors.white,
                //     shape: BoxShape.circle,
                //   ),
                //   child: BackButton(color: AppColors.black,),
                // ),
              ),
              const SizedBox(width: 115),

              const CustomText(
                text: 'Notification',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),

        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: 4, 
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NotificationCard(
                img: AssetImage(AppImages.profile),
                title: 'Sunset Cinema announced Outdoor Movie Night this Friday ',
                subtitle: "Free Entry + Popcorn!",
                time: "3h",
              ),
              );
          },
        ),
      ),
    );
  }
}