import 'package:get/get.dart';
import '../../view/screens/host_part/event/controller/event_controller.dart';
import '../../view/screens/host_part/home/controller/home_controller.dart';
import '../../view/screens/host_part/profile/controller/profile_controller.dart';
import '../../view/screens/host_part/social/controller/social_controller.dart';
import '../../view/screens/thrillseekers_part/social/controller/dm_social_controller.dart';
class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => EventController(), fenix: true);
    Get.lazyPut(() => SocialController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);

    ///==========================DM Part  Controller ==================
    Get.lazyPut(() => DmSocialController(), fenix: true);

  }
}
