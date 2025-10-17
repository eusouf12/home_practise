import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../host_part/profile/controller/profile_controller.dart';
import '../../../../host_part/profile/profile_screen/change_password_screen.dart';

class DmChangePasswordScreen extends StatelessWidget {
  DmChangePasswordScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.resetPasswordFields();
    });

    return ChangePasswordScreen();
  }
}
