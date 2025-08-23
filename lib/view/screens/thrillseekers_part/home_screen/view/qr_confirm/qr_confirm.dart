import 'package:event_platform/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class QrConfirm extends StatefulWidget {
  const QrConfirm({super.key});

  @override
  State<QrConfirm> createState() => _QrConfirmState();
}

class _QrConfirmState extends State<QrConfirm> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: Container(
              height: 38.5.h,
              width: 38.5.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: BackButton(onPressed: (){
                Get.toNamed(AppRoutes.dmHomeScreen);
              },
                  color: AppColors.black
              ),
            ),
            title: CustomText(
              text: "Event Check-In",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),
           body: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
               CustomImage(imageSrc: AppImages.qrImage),
                SizedBox(height: 45,),
                CustomText(
                  text: "Please show the QR to start Event",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
             ),
           ),
        ),
      ),
    );
  }
}
