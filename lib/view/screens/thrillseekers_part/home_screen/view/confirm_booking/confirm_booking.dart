import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../widget/custom_booking card/custom_booking_card.dart';
import '../../widget/custom_live_details/custom_live_comment.dart';
import '../../widget/payment_method_card/payment_method_card.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Confirm Booking",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // song+date+location
                    Column(
                      children: [
                        CustomBookingCard(
                          preImg: AssetImage(AppIcons.musice),
                          subtitle: "Experience the best urban music",
                        ),
                        SizedBox(height: 16),
                        CustomBookingCard(
                          preImg: AssetImage(AppIcons.calenderIcon),
                          title: "May 28, 2025 – 6:00 PM",
                          titleFontSize: 14,
                          titleFontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 16),
                        CustomBookingCard(
                          preImg: AssetImage(AppIcons.locationIcon),
                          title: "Downtown LA",
                          titleFontSize: 14,
                          titleFontWeight: FontWeight.w400,
                        ),
                        //Ticket Information
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 8,
                            left: 5,
                          ),
                          child: Row(
                            children: [
                              CustomImage(imageSrc: AppIcons.ticket),
                              SizedBox(width: 8),
                              CustomText(
                                text: "Ticket Information",
                                fontSize: 13.6,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        //Ticket InformationQuantity+Prise+Booking
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8,right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                               padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Quantity",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.primary,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      text: "1",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: "Price per Ticket",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.primary,
                                  ),
                                  Spacer(),
                                  CustomText(
                                    text: "\$20.00",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),

                            ],
                          ),
                        ),

                        //total pay

                        Padding(
                          padding: const EdgeInsets.only(bottom: 30,top: 13),
                          child: Card(
                            color: Colors.white,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16,bottom: 16,left: 16,right: 8),
                              child: CustomLiveComment(
                                isPreIcon: true,
                                isTrue: true,
                                title: "Price per Ticket",
                                title2: "\$21.00",
                                subtitle: "Includes all fees",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontWeight3: FontWeight.w400,
                                fontSize3: 12,
                                fontWeight2: FontWeight.w700,
                                fontSize2: 16,
                                color: AppColors.black,
                                color2: AppColors.primary,
                                color3: AppColors.red,

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    PaymentMethoodCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
