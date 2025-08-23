import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../widget/custom_live_details/custom_live_comment.dart';

class DmUpcomingDetails extends StatefulWidget {
  const DmUpcomingDetails({
    super.key,
  });

  @override
  State<DmUpcomingDetails> createState() => _DmUpcomingDetailsState();
}

class _DmUpcomingDetailsState extends State<DmUpcomingDetails> {
  int ticketCount = 1;
  double totalPrice = 20.0;

  void handleCountChange(int count, double price) {
    setState(() {
      ticketCount = count;
      totalPrice = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Details Page",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomNetworkImage(
                          imageUrl: AppConstants.ntrition,
                          height: 150.h,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                          width: MediaQuery.sizeOf(context).width),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.5,
                          vertical: 13,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: 'Live Jazz Night',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  bottom: 4,
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 113,
                                  height: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: AppColors.primary3),
                                    ),
                                    child: Row(
                                      children: [
                                        // Hour container
                                        Flexible(
                                          child: Container(
                                            height: double.infinity,
                                            color: AppColors.primary3,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '01',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Colon separator
                                        Container(
                                          width: 17,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Minute container
                                        Flexible(
                                          child: Container(
                                            height: double.infinity,
                                            color: AppColors.primary3,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '23',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Colon separator
                                        Container(
                                          width: 17,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Second container
                                        Flexible(
                                          child: Container(
                                            height: double.infinity,
                                            color: AppColors.primary3,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '45',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //title detail
                            CustomText(
                              text:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididuntut laboore at dolore magna aliqua',
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              bottom: 8,
                              top: 2,
                            ),
                            SizedBox(height: 11.03),
                            // joined+Invited+18+
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.invitedScreen);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.r, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.red_02,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                     Icon(Icons.group_add, color: AppColors.white,),
                                        SizedBox(width: 5),
                                        CustomText(
                                          text: 'Invite',
                                          color: AppColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // SizedBox(width: 25),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.venueFacility);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: 'Venue Facility',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 25),
                                //18
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: AppColors.greyLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: '18+',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 21),
                            CustomLiveComment(
                              preIcon: AssetImage(AppIcons.musice,),
                              isPreIcon: true,
                              title: "CityGroove Fest",
                              subtitle: "Experience the best urban music",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.3,
                              fontSize3: 11.9,
                              color3: AppColors.primary,
                            ),
                            SizedBox(height: 16),
                            //date
                            CustomLiveComment(
                              preIcon: AssetImage(AppIcons.calenderIcon),
                              isPreIcon: true,
                              title: "May 28, 2025 – 6:00 PM",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 16),
                            //location
                            CustomLiveComment(
                              preIcon: AssetImage(AppIcons.locationIcon),
                              isPreIcon: true,
                              title: "Downtown LA",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 11),
                            Divider(thickness: 1, color: AppColors.primary),
                            SizedBox(height: 20),

                            //Quantity
                            CustomLiveComment(
                              isPreIcon: true,
                              isCount: true,
                              isTrue: true,
                              title: "Quantity",
                              ticketPrice: 20.0,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.primary,
                              onCountChanged: handleCountChange,
                            ),
                            // Price per Ticket
                            CustomLiveComment(
                              isPreIcon: true,
                              isTrue: true,
                              title: "Price per Ticket",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontWeight2: FontWeight.w500,
                              fontSize2: 14,
                              color: AppColors.primary,
                              color2: AppColors.black,
                              externalCount: ticketCount,
                              externalTotalPrice: totalPrice,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 21,
                ),
                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.confirmBooking);
                  },
                  height: 70,
                  fillColor: AppColors.primary,
                  title: "Book a ticket",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 77),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
