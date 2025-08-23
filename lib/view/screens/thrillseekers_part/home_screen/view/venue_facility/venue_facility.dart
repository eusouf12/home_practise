import 'package:flutter/material.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../widget/custom_facility_card/custom_facility_card.dart';

class VenueFacility extends StatefulWidget {
  const VenueFacility({super.key});

  @override
  State<VenueFacility> createState() => _VenueFacilityState();
}

class _VenueFacilityState extends State<VenueFacility> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "Venue Facilities",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Washroom",
                  description: "Available beside the main gate and behind the food court.",
                  preicon: CustomImage(imageSrc: AppIcons.washroom),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),

                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Hand Wash Station",
                  description: "Located near every washroom and at the back of the food court.",
                  preicon: CustomImage(imageSrc: AppIcons.hand),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),

                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Smoking Zone",
                  description: "Far-left corner of the venue, away from main crowd.",
                  preicon: CustomImage(imageSrc: AppIcons.smoking),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),

                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Food Court",
                  description: "Center-right of the venue, near the main stage.",
                  preicon: CustomImage(imageSrc: AppIcons.food),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),

                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Rest Area",
                  description: "Left side under the shaded tent.",
                  preicon: CustomImage(imageSrc: AppIcons.rest),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
