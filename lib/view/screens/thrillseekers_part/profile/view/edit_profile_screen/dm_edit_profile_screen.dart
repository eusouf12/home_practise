import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../host_part/profile/controller/profile_controller.dart';
import '../../../../host_part/profile/profile_screen/update_profile_screen.dart';

class DmEditProfileScreen extends StatelessWidget {
   DmEditProfileScreen({super.key});
   final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return UpdateProfileScreen();
  }
}
