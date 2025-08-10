import 'package:event_management/utils/app_colors/app_colors.dart';
import 'package:event_management/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomRoleCard extends StatelessWidget {
  final Widget img;
  final String title;
  final String subtitle;
  final bool isSelected;

  const CustomRoleCard({
    super.key,
    required this.img,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: isSelected ? AppColors.green_01 : AppColors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            img,
            const SizedBox(height: 9),
            CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isSelected ? AppColors.white : AppColors.black,
            ),
            CustomText(
              text: subtitle,
              maxLines: 4,
              fontSize: 11,
              color: isSelected ? AppColors.white : AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}