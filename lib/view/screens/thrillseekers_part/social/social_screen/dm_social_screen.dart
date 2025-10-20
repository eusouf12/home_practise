import 'package:event_platform/view/screens/host_part/social/controller/social_controller.dart';
import 'package:event_platform/view/screens/host_part/social/social_screen/social_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../host_part/profile/controller/profile_controller.dart';

class DmSocialScreen extends StatelessWidget {
   DmSocialScreen({super.key});

   final socialController = Get.put(SocialController());
   final ProfileController profileController = Get.put(ProfileController());

   @override
   Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
       profileController.getUserProfile();
       socialController.getAllStories();
       socialController.fetchInitialPost();
       socialController.getAllGroups();
     });
    return SocialScreen();

  }
}

