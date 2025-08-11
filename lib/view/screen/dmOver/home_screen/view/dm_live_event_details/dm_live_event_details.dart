import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/custom_live_details/custom_live_comment.dart';
import 'package:event_management/view/screen/dmOver/home_screen/widget/custom_live_details/custom_live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_images/custom_images.dart';
import '../../../../../components/custom_test_field/custom_text_field.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmLiveEventDetails extends StatefulWidget {
  const DmLiveEventDetails({super.key});

  @override
  State<DmLiveEventDetails> createState() => _DmLiveEventDetailsState();
}

class _DmLiveEventDetailsState extends State<DmLiveEventDetails> {
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
                SizedBox(height: 20,),
                Card(
                  child: Column(
                    children: [
                      // card ing
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.r),
                        ),
                        child: CustomImage(
                          imageSrc: AppImages.card,
                          fit: BoxFit.cover,
                          height: 150.h,
                          width: double.infinity,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.5,vertical: 13),
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
                              ],
                            ),

                            CustomText(
                              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididuntut laboore at dolore magna aliqua',
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              bottom: 8,
                            ),
                            // public group
                            Row(
                              children: [
                                CustomText(text: 'Public Group',fontSize: 14,),
                                SizedBox(width: 40),
                                CustomImage(imageSrc: AppIcons.users),
                                CustomText(text: 'Public Group',fontSize: 14,left: 5,),
                              ],
                            ),
                            SizedBox(height: 11.03),
                            // joined+Invited+18+
                            Row(
                              children: [
                                //joined
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 48,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: AppColors.white4,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImage(
                                          imageSrc: AppIcons.join,
                                        ),
                                        SizedBox(width: 5),
                                        CustomText(
                                          text: 'Joined',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),

                                GestureDetector(
                                  onTap: () {
                                    // Get.toNamed(AppRoutes.inviteScreen);
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 104,
                                    decoration: BoxDecoration(
                                      color: AppColors.red_03,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImage(
                                          imageSrc: AppIcons.invite,
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

                                SizedBox(width: 25),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 48,
                                      width: 62,
                                      decoration: BoxDecoration(
                                        color: AppColors.white4,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          text: '18+',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
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
                                  color: AppColors.white4,
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


                            SizedBox(height: 14.4),
                            Divider(thickness: 1,color: AppColors.green_01,),
                            SizedBox(height: 16),
                            // write something

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 20, // Adjust size
                                  backgroundImage: AssetImage(
                                    'assets/images/img.jpg',
                                  ),
                                ),
                                // CustomFormCard(title: '', controller: TextEditingController()),
                               SizedBox(width: 5,),
                                Expanded(
                                  child: CustomTextField(
                                    onTap: () {
                                      // Get.toNamed(AppRoutes.createPostScreen,);
                                    },
                                    hintText: 'Write Something...',
                                    height: 28,
                                    fontSize: 12,
                                    color: Colors.black,
                                    fillColor: Colors.transparent,
                                    fieldBorderColor: Colors.black,
                                    readOnly: true,
                                    fieldBorderRadius: 15,

                                  ),
                                ),
                                SizedBox(width: 22,),
                                InkWell(
                                  onTap: () {
                                    // Get.toNamed(AppRoutes.createPostScreen);
                                  },
                                  child: CustomImage(
                                    imageSrc: AppIcons.vector,

                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 39.21),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomImage(imageSrc: AppIcons.live),
                                SizedBox(width: 5),
                                CustomText(
                                  text: 'Live Comments',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              
                                Expanded(
                                  child: CustomImage(
                                    imageSrc: AppIcons.clock,
                                    height: 22.6,
                                    width: 22.6,
                                  ),
                                ),
                                CustomText(text: '01:20 Hours',fontSize: 12, left: 5),
                                Container(
                                  height: 37.83,
                                  width: 37.83,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColors.green, 
                                      width: 4, 
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
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 10.09),
                            Divider(thickness: 1, color: AppColors.black),

                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: 4,
                              separatorBuilder: (_, __) => const SizedBox(height: 20),
                              itemBuilder: (context, index) {
                                return CustomLiveComment();
                              },
                            ),

                            SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppImages.profile,
                                        ), 
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  CustomTextField(
                                    height: 45,
                                    weight: 180,
                                    fillColor: AppColors.green4,
                                    color: Colors.white,
                                    hintText: 'Write a comment',
                                    fieldBorderRadius: 15,
                                  ),
                                  SizedBox(width: 10),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: AppColors.green_01,
                                        ),
                                        child: CustomImage(imageSrc: AppIcons.telegram, imageColor: Colors.white,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // 1st card
                            CustomLiveDetails(),
                            // 2nd cardCl
                            CustomLiveDetails(),

                            SizedBox(height: 188),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
