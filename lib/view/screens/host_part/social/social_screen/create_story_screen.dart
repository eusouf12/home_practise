import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
class CreateStoryScreen extends StatelessWidget {
  const CreateStoryScreen({super.key});

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomRoyelAppbar(leftIcon: true, titleName: "Create Story"),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Color(0xff96C9B8)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file,size: 50,color: Color(0xff96C9B8)),
                            CustomText(
                              top: 10.h,
                              text: 'Upload a photo or video',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      CustomFormCard(title: AppStrings.addMessage,
                          hintText: AppStrings.whatOnYourMind,
                          maxLine: 4,
                          controller: TextEditingController()),
                      CustomButton(onTap: (){}, title: "Post To Story",)

                    ],
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}
