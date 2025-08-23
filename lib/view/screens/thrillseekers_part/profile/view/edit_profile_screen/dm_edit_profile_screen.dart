import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class DmEditProfileScreen extends StatelessWidget {
  const DmEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoyelAppbar(leftIcon: true, titleName: "Update Profile"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 140.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary, // Border color
                                width: 4, // Border width
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: CustomNetworkImage(
                                imageUrl: AppConstants.profileImage,
                                height: 70.h,
                                width: 70.w,
                                boxShape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 120.w,
                          bottom: 10.w,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: .7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary, // Border color
                                width: 4, // Border width
                              ),
                            ),
                            child: Icon(Icons.edit, size: 15),
                          ),
                        ),
                      ],
                    ),
                    // TextField(t),
                    CustomFormCard(
                      title: 'Name',
                      fontSize: 16,
                      hintText: 'Debbendu Paul',
                      controller: TextEditingController(),
                    ),
                    CustomFormCard(
                      title: 'Email',
                      hintText: 'debbendu195@gmail.com',
                      controller: TextEditingController(),
                    ),
                    CustomFormCard(
                      title: 'Number',
                      hintText: '+91 1234567890',
                      controller: TextEditingController(),
                    ),
                    CustomFormCard(
                      title: 'Date of Birth',
                      hintText: '10/10/2023',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 31),
                    CustomButton(
                      onTap: () {},
                      title: 'Save Changes',
                      fillColor: AppColors.primary,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
