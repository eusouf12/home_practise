/*
import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';

class SupportFeedbackScreen extends StatelessWidget {
  const SupportFeedbackScreen({super.key});

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
                titleName: "Support & Feedback",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      top: 20,
                      text:
                          'Reach out to us anytime. Our team is available 24/7',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_80,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      bottom: 20,
                    ),
                    CustomFormCard(
                      title: 'Name',
                      controller: TextEditingController(),
                      hintText: 'Your Name',
                    ),
                    CustomFormCard(
                      title: 'Email',
                      controller: TextEditingController(),
                      hintText: 'email@gmail.com',
                    ),
                    CustomFormCard(
                      title: 'Select Subject',
                      controller: TextEditingController(),
                      hintText: 'Select A Subject',
                    ),
                    CustomFormCard(
                      title: 'Message',
                      controller: TextEditingController(),
                      hintText: 'Write Your Message here...',
                    ),
                    CustomButton(
                      onTap: () {},
                      title: 'Send Request',
                      fillColor: AppColors.primary,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
          // bottomNavigationBar: HostNavbar(currentIndex: 0,),
        ],
      ),
    );
  }
}
*/
