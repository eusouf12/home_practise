import 'package:event_platform/view/components/custom_image/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_text/custom_text.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

             CustomImage(imageSrc: AppImages.success),
              SizedBox(height: 24,),
              CustomText(
                text: "Ticket confirmed",
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AppColors.black_80,
              ),
              SizedBox(height: 16,),
              CustomText(
                text: "Thank you for your order. You will receive email confirmation shortly.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black_80,
                maxLines: 10,
              ),
              SizedBox(height: 40,),
              CustomButton(onTap: (){
                Get.toNamed(AppRoutes.qrConfirm);
              },
                title: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
