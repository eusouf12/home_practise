import 'package:event_management/view/screen/dmOver/home_screen/view/dm_home_screen.dart';
import 'package:event_management/view/screen/host/home_screen/view/host_home_screen.dart';
import 'package:event_management/view/screen/profile_role/profile_role_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String profileRoleScreen = '/profileRoleScreen';
  static const String dmHomeScreen = '/dmHomeScreen';
  static const String hostHomeScreen = '/hostHomeScreen';

  static List<GetPage> routes = [
    GetPage(name: profileRoleScreen, page: () => ProfileRoleScreen()),
    GetPage(name: dmHomeScreen, page: () => DmHomeScreen()),
    GetPage(name: hostHomeScreen, page: () => HostHomeScreen()),


  ];
}
