import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../host_part/profile/controller/profile_controller.dart';
import '../../../../host_part/profile/profile_screen/privacy_policy_screen.dart';

class DmPrivacyScreen extends StatelessWidget {
   DmPrivacyScreen({super.key});
   final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getPrivacyPolicy();

    });
    return PrivacyPolicyScreen();
  }
}
