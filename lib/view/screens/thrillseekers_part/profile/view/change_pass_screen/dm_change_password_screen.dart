import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';

class DmChangePasswordScreen extends StatelessWidget {
  const DmChangePasswordScreen({super.key});

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
              CustomRoyelAppbar(
                leftIcon: true,
                titleName: "Change Password",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      fillColor: Colors.transparent,
                      fieldBorderColor: Color(0xff96C9B8),
                      isPassword: true,
                      hintText: 'Current Password',
                      hintStyle: TextStyle(
                        color: AppColors.black_05,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      fillColor: Colors.transparent,
                      fieldBorderColor: Color(0xff96C9B8),
                      isPassword: true,
                      hintText: 'New Password',
                      hintStyle: TextStyle(
                        color: AppColors.black_05,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      fillColor: Colors.transparent,
                      fieldBorderColor: Color(0xff96C9B8),
                      isPassword: true,
                      hintText: 'Retype Password',
                      hintStyle: TextStyle(
                        color: AppColors.black_05,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: CustomButton(
              onTap: () {},
              title: 'Save Changes',
              fillColor: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}
