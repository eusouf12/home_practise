import 'package:event_management/view/screen/dmOver/favourite/view/favourite_screen.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_home_screen/dm_home_screen.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_notification_screen/dm_notification_screen.dart';
import 'package:event_management/view/screen/dmOver/message/view/message_screen/message_screen.dart';
import 'package:event_management/view/screen/dmOver/social/view/social_media_screen/social_media_screen.dart';
import 'package:event_management/view/screen/host/home_screen/view/host_home_screen.dart';
import 'package:event_management/view/screen/profile_role/profile_role_screen.dart';
import 'package:get/get.dart';


class AppRoutes {
  static const String profileRoleScreen = '/profileRoleScreen';
  static const String dmHomeScreen = '/dmHomeScreen';
  static const String hostHomeScreen = '/hostHomeScreen';
  static const String favouriteScreen = '/fravouriteScreen';
  static const String messageScreen = '/messageScreen';
  static const String profileScreen = '/profileScreen';
  static const String socialScreen = '/socialScreen';
  static const String notificationScreen = '/notificationScreen';


  static List<GetPage> routes = [
    GetPage(name: profileRoleScreen, page: () => ProfileRoleScreen()),
    GetPage(name: dmHomeScreen, page: () => DmHomeScreen()),
    GetPage(name: hostHomeScreen, page: () => HostHomeScreen()),
    GetPage(name: favouriteScreen, page: () => FavouriteScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),
    GetPage(name: socialScreen, page: () => SocialMediaScreen()),
    GetPage(name: profileScreen, page: () => HostHomeScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),


  ];
}