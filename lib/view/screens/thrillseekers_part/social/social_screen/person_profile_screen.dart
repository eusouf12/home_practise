
import 'package:event_platform/core/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../host_part/social/widgets/custom_post.dart';

class PersonProfileScreen extends StatefulWidget {
  const PersonProfileScreen({super.key});

  @override
  State<PersonProfileScreen> createState() => _PersonProfileScreenState();
}

class _PersonProfileScreenState extends State<PersonProfileScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Sarah Williams'),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Profile Image
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
          
                        ],
                      ),
                      child: ClipOval(
                        child: CustomNetworkImage(imageUrl: AppConstants.profileImage
                            , height: 100, width: 100),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomText(text: 'Sarah Williams',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:AppColors.black,
                    ),
                    CustomText(text: '@alexJhon',
                      fontSize: 12,
                      color:AppColors.black_80,
                    ),
                     SizedBox(height: 8),
                    // btn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Follow Button
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            selectedIndex == 0 ? AppColors.primary : AppColors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: CustomText(
                            text: 'Follow',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == 0 ? Colors.white : AppColors.black,
                          ),
                        ),
          
                        const SizedBox(width: 20),
          
                        // Message Button
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            selectedIndex == 1 ? AppColors.primary : AppColors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: CustomText(
                            text: 'Message',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: selectedIndex == 1 ? Colors.white : AppColors.black,
                          ),
                        ),
                      ],
                    ),
          
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Divider(thickness: 1,color: AppColors.primary,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Column(
                       children: [
                         CustomText(text: 'About',
                           fontSize: 16.w,
                           color:AppColors.black,
                           bottom: 12,
                         ),
                         CustomText(text: '2050',
                           fontSize: 16,
                           fontWeight: FontWeight.w700,
                           color:AppColors.black,
                         ),
                       ],
                     ),
                     SizedBox(width: 60,),
                     GestureDetector(
                       onTap: (){
                      Get.toNamed(AppRoutes.dmFollowersScreen);
                       },
                       child: Column(
                         children: [
                           CustomText(text: 'Following',
                             fontSize: 16.w,
                             color:AppColors.black,
                             bottom: 12,
                           ),
                           CustomText(text: '450',
                             fontSize: 16,
                             fontWeight: FontWeight.w700,
                             color:AppColors.black,
                           ),
                         ],
                       ),
                     ),
                    SizedBox(width: 60,),
                     Column(
                       children: [
                         CustomText(text: 'Post',
                           fontSize: 16.w,
                           bottom: 12,
                           color:AppColors.black,
                         ),
                         CustomText(text: '10',
                           fontSize: 16,
                           fontWeight: FontWeight.w700,
                           color:AppColors.black,
                         ),
                       ],
                     )
                  ],
                ),
              ),
              Divider(thickness: 1,color: AppColors.primary,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: List.generate(3, (index){
                      return CustomPost();
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
