import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/screens/host_part/social/widgets/custom_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../../../thrillseekers_part/home_screen/widget/custom_live_details/custom_live_comment.dart';


class IndividualGroupDetails extends StatefulWidget {
  IndividualGroupDetails({super.key});

  @override
  State<IndividualGroupDetails> createState() => _IndividualGroupDetails();
}

class _IndividualGroupDetails extends State<IndividualGroupDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Live Details'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                // card ing
                CustomNetworkImage(
                  imageUrl: AppConstants.ntrition,
                  height: 150.h,
                  width: MediaQuery.sizeOf(context).width,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //before 1st divider
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Live Jazz Night
                          CustomText(
                            text: 'Live Jazz Night',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            bottom: 4,
                          ),

                          CustomText(
                            text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididuntut laboore at dolore magna aliqua',
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            bottom: 8,
                          ),
                          // joined+Invited+18+
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //joined
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.greyLight,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.group),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: 'Joined',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoutes.invitedScreen);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.group_add,
                                        color: AppColors.white,
                                      ),
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


                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                decoration: BoxDecoration(
                                  color: AppColors.greyLight,
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: '18+',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13),
                          //Venue
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.venueFacility);
                            },
                            child: Container(
                              height: 48,
                              width: 121,
                              decoration: BoxDecoration(
                                color: AppColors.greyLight,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: CustomText(
                                text: 'Venue Facility',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.primary,
                    ),
                    // write something
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 50.h,
                            width: 50.w,
                            boxShape: BoxShape.circle,
                          ),
                          // CustomFormCard(title: '', controller: TextEditingController()),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: CustomTextField(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.createPostScreen,
                                );
                              },
                              hintText: 'Write Something...',
                              hintStyle: TextStyle(
                                color: AppColors.black_80,
                              ),
                              fillColor: Colors.transparent,
                              fieldBorderColor: Colors.black,
                              readOnly: true,
                              fieldBorderRadius: 15,
                            ),
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          InkWell(
                            onTap: () {
                              // Get.toNamed(AppRoutes.createPostScreen);
                            },
                            child: Icon(Icons.image),
                          ),
                        ],
                      ),
                    ),
                    // live comment
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 3, left: 10, right: 10, bottom: 19),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_call,
                            color: AppColors.red,
                          ),
                          CustomText(
                            text: 'Live Comments',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            left: 5,
                            // right: 60,
                          ),
                          Spacer(),
                          //clock
                          Icon(Icons.access_time),
                          CustomText(
                            text: '01:20 Hours',
                            left: 7,
                            right: 15,
                          ),
                          Container(
                            height: 37.83,
                            width: 37.83,
                            decoration: BoxDecoration(
                              color: Colors.white, // Optional background color
                              border: Border.all(
                                color: AppColors.green, // Border color
                                width: 3, // Border width
                              ),
                              borderRadius: BorderRadius.circular(
                                30,
                              ), // Optional rounded corners
                            ),
                            child: Center(
                              child: CustomText(
                                text: 'Good',
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1, color: AppColors.black),
                    //cmt scroll
                    Container(
                      height: 262,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: 10,
                          separatorBuilder: (_, __) =>
                          const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            return CustomLiveComment(
                              title2: '01:31',
                              subtitle:
                              "I've been to their previous events. The music is always top notch!",
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    //Write a comment
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: AppConstants.profileImage,
                              height: 50.h,
                              width: 50.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: CustomTextField(
                                fillColor: AppColors.primary,
                                hintText: 'Write a comment',
                                fieldBorderRadius: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.primary,
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: List.generate(2, (index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 14),
                              child: CustomPost(),
                            ),
                            if (index != 1) // count-1
                              Divider(color: Colors.grey.shade300, height: 1),
                          ],
                        );
                      }),
                    ),
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
