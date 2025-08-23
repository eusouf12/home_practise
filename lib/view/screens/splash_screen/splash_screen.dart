// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_images/app_images.dart';
import '../../components/custom_image/custom_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  //final AuthController authController =Get.find<AuthController>();
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
       // Get.offAllNamed(AppRoutes.loginScreen);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
        CustomImage(
          imageSrc: AppImages.backG,
          width: size.width,
          height: size.height,
          boxFit: BoxFit.cover,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 60.0, right: 20.w, left: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(child: CustomImage(imageSrc: AppImages.splashImage)),
              CustomText(
                top: 20.h,
                text: AppStrings.plan,
                fontSize: 32.w,
                fontWeight: FontWeight.w600,
              ),
              CustomButton(onTap: (){
                Get.offAllNamed(AppRoutes.loginScreen);
              }, title: AppStrings.getStarted,)
            ],
          ),
        )
      ],
    ));
  }
}
