import 'package:event_management/view/screen/dmOver/home_screen/view/dm_home_screen/dm_home_screen.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_live_event/dm_live_event.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_live_event_details/dm_live_event_details.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_upcoming_details/dm_upcoming_details.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/dm_upcoming_event_screen/dm_upcoming_event_screen.dart';
import 'package:event_management/view/screen/dmOver/home_screen/view/notification_screen/notification_screen.dart';
import 'package:event_management/view/screen/dmOver/message/view/message_screen/messege_screen.dart';
import 'package:event_management/view/screen/dmOver/social/view/social_media/social_media_screen.dart';
import 'package:event_management/view/screen/host/home_screen/view/host_home_screen.dart';
import 'package:event_management/view/screen/profile_role/profile_role_screen.dart';
import 'package:get/get.dart';

import '../../view/screen/dmOver/favorite/view/favourite_screen/favourite_screen.dart';

class AppRoutes {
  static const String profileRoleScreen = '/profileRoleScreen';
  static const String dmHomeScreen = '/dmHomeScreen';
  static const String hostHomeScreen = '/hostHomeScreen';
  static const String favouriteScreen = '/fravouriteScreen';
  static const String messageScreen = '/messageScreen';
  static const String profileScreen = '/profileScreen';
  static const String socialScreen = '/socialScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String dmLiveScreen = '/dmLiveScreen';
  static const String dmLiveEventDetails = '/dmLiveEventDetails';
  static const String dmUpcomingEventScreen = '/dmUpcomingEventScreen';
  static const String dmUpcomingEventDetails = '/dmUpcomingEventDetails';


  static List<GetPage> routes = [
    GetPage(name: profileRoleScreen, page: () => ProfileRoleScreen()),
    GetPage(name: dmHomeScreen, page: () => DmHomeScreen()),
    GetPage(name: hostHomeScreen, page: () => HostHomeScreen()),
    GetPage(name: favouriteScreen, page: () => FavouriteScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),
    GetPage(name: socialScreen, page: () => SocialMediaScreen()),
    GetPage(name: profileScreen, page: () => HostHomeScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: dmLiveScreen, page: () => DmLiveEvent()),
    GetPage(name: dmLiveEventDetails, page: () => DmLiveEventDetails()),
    GetPage(name: dmUpcomingEventScreen, page: () => DmUpcomingEventScreen()),
    GetPage(name: dmUpcomingEventDetails, page: () => DmUpcomingDetails()),


  ];
}
