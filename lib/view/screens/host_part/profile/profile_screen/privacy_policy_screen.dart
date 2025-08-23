import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
              CustomRoyelAppbar(leftIcon: true,titleName: "Privacy Policy",),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: CustomText(
                  text:
                      "We respect your privacy. When you use our app, we collect basic info like your name, email, and event preferences to help you manage, join, or host events easily.",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w400,
                  maxLines: 10,
                  //overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ],
      ),
      // bottomNavigationBar: HostNavbar(currentIndex: 0,),
    );
  }
}
