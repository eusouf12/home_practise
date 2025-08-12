import 'package:event_management/core/app_routes/app_routes.dart';
import 'package:event_management/utils/app_colors/app_colors.dart';
import 'package:event_management/utils/app_images/app_images.dart';
import 'package:event_management/view/components/custom_button/custom_button.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/components/custom_images/custom_images.dart';
import 'package:event_management/view/components/custom_role_card/custom_role_card.dart';
import 'package:event_management/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileRoleScreen extends StatefulWidget {
  const ProfileRoleScreen({super.key});
  @override
  State<ProfileRoleScreen> createState() => _ProfileRoleScreenState();
}

class _ProfileRoleScreenState extends State<ProfileRoleScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                   CustomText(
                    text: 'Choose Your Role',
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                  SizedBox(height: 16),

                  CustomText(
                    text: "What type of account you want?\nWho are you? Select an option\n to continue",
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 44),
                  // card

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: CustomRoleCard(
                              img: CustomImage(
                                imageSrc: AppImages.object_1,
                                height: 100,
                              ),
                              title: 'HOST',
                              subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                              isSelected: selectedIndex == 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: CustomRoleCard(
                              img: CustomImage(
                                imageSrc: AppImages.object_2,
                                height: 100,
                              ),
                              title: 'DMOVER',
                              subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                              isSelected: selectedIndex == 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 166),

                  //btn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: CustomButton(
                      onTap: () {
                        if (selectedIndex == -1) return;
                        if (selectedIndex == 0) {
                          Get.toNamed(AppRoutes.hostHomeScreen);
                        } else if (selectedIndex == 1) {
                          Get.toNamed(AppRoutes.dmHomeScreen);
                        }
                      },

                      title: "Continue",
                      fontSize: 16,
                      textColor: selectedIndex != -1? AppColors.white :AppColors.white3,
                      fontWeight: FontWeight.w700,
                      fillColor: selectedIndex != -1? AppColors.green_01 :AppColors.green3,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
