import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../host_part/profile/controller/profile_controller.dart';
import '../../../../host_part/profile/profile_screen/terms_condition_screen.dart';


class DmTermsConditionScreen extends StatelessWidget {
   DmTermsConditionScreen({super.key});
   final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return TermsConditionScreen();
  }
}
