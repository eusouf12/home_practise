import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/custom_booking%20card/custom_booking_card.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/payment_method_card/payment_methood_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
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
                    text: " Confirm Booking",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    // song+date+location
                    Column(
                      children: [
                        CustomBookingCard(
                          subtitle: "Experience the best urban music",
                        ),
                        SizedBox(height: 16),
                        CustomBookingCard(
                          preImg: AssetImage(AppIcons.calender3),
                          title: "May 28, 2025 – 6:00 PM",
                          titleFontSize: 14,
                          titleFontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 16),
                        CustomBookingCard(
                          preImg: AssetImage(AppIcons.location3),
                          title: "Downtown LA",
                          titleFontSize: 14,
                          titleFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),

                    PaymentMethoodCard()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
