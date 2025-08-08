import 'package:event_management/core/app_routes/app_routes.dart';
import 'package:event_management/utils/app_icons/app_icons.dart';
import 'package:event_management/utils/app_images/app_images.dart';
import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/components/custom_images/custom_images.dart';
import 'package:event_management/view/components/custom_test_field/custom_text_field.dart';
import 'package:event_management/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DmHomeScreen extends StatefulWidget {
  const DmHomeScreen({super.key});

  @override
  State<DmHomeScreen> createState() => _DmHomeScreenState();
}

class _DmHomeScreenState extends State<DmHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(AppImages.profile),
                    ),
                    SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Good Morning",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),

                        CustomText(
                          text: "Alexa",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.profileRoleScreen);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF7FFEF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: CustomImage(
                        imageSrc: AppIcons.notificartion,
                    ),
                ),
                ),],
            ),
          ),

          //body
          body:Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomText(
                 text: 'Find Best Events\nNear You',
                 textAlign: TextAlign.left,
                 fontSize: 24,
                 fontWeight: FontWeight.w600,
               ),

               CustomTextField(
                 hintText: 'Explore events' ,
               ),

             ],
          ),

          ),
      );
  }
}
