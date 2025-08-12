import 'package:event_management/view/components/custom_button/custom_button.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/custom_live_details/custom_live_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmUpcomingDetails extends StatefulWidget {

  const DmUpcomingDetails({
    super.key,
  });

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
                ),
                SizedBox(height: 20),

                Card(
                  child: Column(
                    children: [
                      // card ing
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: CustomImage(
                          imageSrc: AppImages.card,
                          fit: BoxFit.cover,
                          height: 150.h,
                          width: double.infinity,
                        ),
                      ),

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
                                      border: Border.all(color: AppColors.grey_09),
                                    ),
                                    child: Row(
                                      children: [
                                        // Hour container
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            color: AppColors.color3,
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
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Minute container
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            color: AppColors.color3,
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
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Second container
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            color: AppColors.color3,
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

                                // need somthing Clock
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
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(AppRoutes.inviteScreen);
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 104,
                                    decoration: BoxDecoration(
                                      color: AppColors.red_03,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImage(imageSrc: AppIcons.invite),
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

                                SizedBox(width: 25),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.venueFacility);
                                    },
                                    child: Container(
                                      height: 48,
                                      width: 121,
                                      decoration: BoxDecoration(
                                        color: AppColors.white4,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Expanded(
                                        child: CustomText(
                                          text: 'Venue Facility',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),
                                //18
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 48,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: AppColors.white4,
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

                            // cityGroove fest
                            CustomLiveComment(
                              preIcon: AssetImage(AppIcons.song),
                              isPreIcon: true,
                              title: "CityGroove Fest",
                              subtitle: "Experience the best urban music",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.3,
                              fontSize3: 11.9,
                              color3: AppColors.grey_06,
                            ),
                            SizedBox(height: 16),
                            //date
                            CustomLiveComment(
                              preIcon: AssetImage(AppIcons.calender2),
                              isPreIcon: true,
                              title: "May 28, 2025 – 6:00 PM",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.grey_07,
                            ),
                            SizedBox(height: 16),
                            //location
                            CustomLiveComment(
                              preIcon: AssetImage(AppIcons.location2),
                              isPreIcon: true,
                              title: "Downtown LA",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.grey_07,
                            ),

                            SizedBox(height: 11),
                            Divider(thickness: 1, color: AppColors.green_01),
                            SizedBox(height: 20),

                            //Quantity
                            CustomLiveComment(
                              isPreIcon: true,
                              isTrue2: true,
                              isTrue: true,
                              title: "Quantity",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.grey_08,
                            ),
                            // Price per Ticket
                            CustomLiveComment(
                              isPreIcon: true,
                              isTrue: true,
                              title: "Price per Ticket",
                              title2: "\$20.00",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontWeight2: FontWeight.w500,
                              fontSize2: 14,
                              color: AppColors.grey_08,
                              color2: AppColors.black,
                            ),
                            //
                            CustomLiveComment(
                              isPreIcon: true,
                              isTrue: true,
                              title: "Booking Fee",
                              title2: "\$1.50",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontWeight2: FontWeight.w500,
                              fontSize2: 14,
                              color: AppColors.grey_08,
                              color2: AppColors.black,
                            ),


                            // ------






                            // ------

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21,),
                CustomButton(onTap: (){
                  Get.toNamed(AppRoutes.confirmBooking);
                },
                  height: 70,
                  fillColor: AppColors.green_01,
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
