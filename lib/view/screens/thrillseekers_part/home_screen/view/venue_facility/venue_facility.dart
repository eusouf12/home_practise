import 'package:flutter/material.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../host_part/home/model/creat_event_model.dart';
import '../../controller/home_controller/dm_home_controller.dart';
import '../../widget/custom_facility_card/custom_facility_card.dart';// VenueFacility model import
import 'package:get/get.dart';

class VenueFacilityScreen extends StatelessWidget {
  VenueFacilityScreen({super.key});

  final DmHomeController dmHomeController = Get.put(DmHomeController());

  // Server থেকে আসা list
  final List<VenueFacility> venueFacilities = Get.arguments as List<VenueFacility>;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      dmHomeController.getLiveEventDetails();
    });
    // Helper function: type অনুযায়ী server থেকে description নেবে
    String getDescription(String type) {
      final facility = venueFacilities.firstWhere(
              (element) => element.type?.toLowerCase() == type.toLowerCase(),
          orElse: () => VenueFacility(description: "Not Available"));
      return facility.description ?? "Not Available";
    }

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
                  description: getDescription("Washroom"),
                  preicon: CustomImage(imageSrc: AppIcons.washroom),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Hand Wash Station",
                  description: getDescription("handwashstation"),
                  preicon: CustomImage(imageSrc: AppIcons.hand),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Smoking Zone",
                  description: getDescription("Smoking Zone"),
                  preicon: CustomImage(imageSrc: AppIcons.smoking),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Food Court",
                  description: getDescription("Food Court"),
                  preicon: CustomImage(imageSrc: AppIcons.food),
                  posticonUp: Icon(Icons.keyboard_arrow_down_outlined),
                  posticonDown: Icon(Icons.keyboard_arrow_up_outlined),
                ),
                SizedBox(height: 7),
                CustomFacilityCard(
                  title: "Rest Area",
                  description: getDescription("Rest Area"),
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
