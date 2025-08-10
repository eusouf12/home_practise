import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/custom_liveevent_card/custom_liveevent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmLiveEvent extends StatefulWidget {
  const DmLiveEvent({super.key});

  @override
  State<DmLiveEvent> createState() => _DmLiveEventState();
}

class _DmLiveEventState extends State<DmLiveEvent> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: Container(
              height: 38.5.h,
              width: 38.5.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: BackButton(color: AppColors.black),
            ),
            title: CustomText(
              text: "Live Events",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),

          body: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: 2, // change as needed
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return CustomLiveEventCard(

              );
            },
          ),
        ),
      ),
    );
  }
}
