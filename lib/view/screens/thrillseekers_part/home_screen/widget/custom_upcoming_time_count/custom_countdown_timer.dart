import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../host_part/home/model/creat_event_model.dart';

class EventCountdown extends StatefulWidget {
  final CreateEventModel event;

  const EventCountdown({super.key, required this.event});

  @override
  State<EventCountdown> createState() => _EventCountdownState();
}

class _EventCountdownState extends State<EventCountdown> {
  Timer? timer;
  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    timer =
        Timer.periodic(Duration(seconds: 1), (_) => _calculateRemainingTime());
  }

  void _calculateRemainingTime() {
    if (widget.event.date == null || widget.event.startingTime == null) return;

    // Combine date & startingTime from backend
    final dateTimeString =
        '${DateFormat('dd-MM-yyyy').format(widget.event.date!)} ${widget.event.startingTime!.trim()}';
    final eventDateTime = DateFormat('dd-MM-yyyy HH:mm').parse(dateTimeString);
    final now = DateTime.now();
    final remaining = eventDateTime.difference(now);

    setState(() {
      this.remaining = remaining.isNegative ? Duration.zero : remaining;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 30,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.primary3),
        ),
        child: Row(
          children: [
            // Hour container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: AppColors.primary3,
              alignment: Alignment.center,
              child: CustomText(
                text: "${hours}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 10,
              alignment: Alignment.center,
              child: Text(
                ':',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: AppColors.primary3,
              alignment: Alignment.center,
              child: CustomText(
                text: "${minutes}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 10,
              alignment: Alignment.center,
              child: Text(
                ':',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: AppColors.primary3,
              alignment: Alignment.center,
              child: CustomText(
                text: "${seconds}",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
