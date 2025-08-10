import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors/app_colors.dart';

class DmUpcomingDetails extends StatefulWidget {
  const DmUpcomingDetails({super.key});

  @override
  State<DmUpcomingDetails> createState() => _DmUpcomingDetailsState();
}

class _DmUpcomingDetailsState extends State<DmUpcomingDetails> {
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
          ),
        ),
      ),
    );
  }
}
