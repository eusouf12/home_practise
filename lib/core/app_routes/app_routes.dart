// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import '../../view/screens/authentication_screen/forgot_screen/forgot_screen.dart';
import '../../view/screens/authentication_screen/login_screen/login_screen.dart';
import '../../view/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import '../../view/screens/choose_role_screen/choose_role_screen.dart';
import '../../view/screens/host_part/home/create_screen/create_screen.dart';
import '../../view/screens/host_part/home/home_screen/home_screen.dart';
import '../../view/screens/host_part/home/host_event_details/host_live_event_details.dart';
import '../../view/screens/host_part/home/notification_screen/notification_screen.dart';
import '../../view/screens/host_part/message/message_screen/message_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/change_password_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/host_followers_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/language_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/payment_setup_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/privacy_policy_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/profile_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/terms_condition_screen.dart';
import '../../view/screens/host_part/profile/profile_screen/update_profile_screen.dart';
import '../../view/screens/host_part/social/social_screen/create_post_screen.dart';
import '../../view/screens/host_part/social/social_screen/create_story_screen.dart';
import '../../view/screens/host_part/social/social_screen/social_screen.dart';
import '../../view/screens/splash_screen/splash_screen.dart';
import '../../view/screens/thrillseekers_part/favorite/view/favourite_screen/favourite_screen.dart';
import '../../view/screens/thrillseekers_part/favorite/view/gellery_screen/gallery_screen.dart';
import '../../view/screens/thrillseekers_part/favorite/view/invited_screen/invited_screen.dart';
import '../../view/screens/thrillseekers_part/favorite/view/update_screen/update_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/Nearby_bar_screen/nearby_bar_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/bar_details_page/bar_details_page.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/bar_resturent_screen/bar_resturent_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/confirm_booking/confirm_booking.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/confirmation/confirmation.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_filter/dm_filter.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_followers_screen/dm_followers_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_home_screen/dm_home_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_live_event/dm_live_event.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_live_event_details/dm_live_event_details.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_upcoming_details/dm_upcoming_details.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/dm_upcoming_event_screen/dm_upcoming_event_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/nearby_restaurants_screen/nearby_restaurants_screen.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/qr_confirm/qr_confirm.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/restaurant_details_page/restaurant_details_page.dart';
import '../../view/screens/thrillseekers_part/home_screen/view/venue_facility/venue_facility.dart';
import '../../view/screens/thrillseekers_part/message/message_screen/dm_message_screen.dart';
import '../../view/screens/thrillseekers_part/profile/view/change_pass_screen/dm_change_password_screen.dart';
import '../../view/screens/thrillseekers_part/profile/view/dm_ticket_scanner_page/dm_ticket_scanner_page.dart';
import '../../view/screens/thrillseekers_part/profile/view/edit_profile_screen/dm_edit_profile_screen.dart';
import '../../view/screens/thrillseekers_part/profile/view/event_history/event_history.dart';
import '../../view/screens/thrillseekers_part/profile/view/privacy_screen/dm_privacy_screen.dart';
import '../../view/screens/thrillseekers_part/profile/view/profile_screen/dm_profile_screen.dart';
import '../../view/screens/thrillseekers_part/profile/view/terms_condition_screen/dm_terms_condition_screen.dart';
import '../../view/screens/thrillseekers_part/profile/view/tickets_history/tickets_history.dart';
import '../../view/screens/thrillseekers_part/social/social_screen/dm_social_screen.dart';
import '../../view/screens/thrillseekers_part/social/social_screen/person_profile_screen.dart';

class AppRoutes {
  ///===========================Authentication==========================
  static const String splashScreen = "/SplashScreen";
  static const String loginScreen = "/LoginScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String chooseRoleScreen = "/ChooseRoleScreen";
  static const String otpScreen = "/otpScreen";
  static const String setNewPassword = "/SetNewPassword";

  ///===========================Host Part==========================
  static const String homeScreen = "/HomeScreen";
  static const String createScreen = "/CreateScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String socialScreen = "/SocialScreen";
  static const String createPostScreen = "/CreatePostScreen";
  static const String createStoryScreen = "/CreateStoryScreen";
  static const String hostUpdateScreen = "/HostUpdateScreen";
  static const String postStory = "/PostStory";
  static const String messageScreen = "/MessageScreen";
  static const String profileScreen = "/ProfileScreen";
  static const String updateProfileScreen = "/UpdateProfileScreen";
  static const String paymentSetupScreen = "/PaymentSetupScreen";
  static const String privacyPolicyScreen = "/PrivacyPolicyScreen";
  static const String termsConditionScreen = "/TermsConditionScreen";
  static const String languageScreen = "/LanguageScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String supportFeedbackScreen = "/SupportFeedbackScreen";
  static const String hostLiveEventDetails = "/HostLiveEventDetails";
  static const String forgotScreen = "/ForgotScreen";
  static const String hostFollowersScreen = "/HostFollowersScreen";
  static const String reportScreen = "/ReportScreen";


  ///===========================Thrill seekers Part==========================
  static const String favouriteScreen = "/FavouriteScreen";
  static const String profileRoleScreen = '/profileRoleScreen';
  static const String dmHomeScreen = '/dmHomeScreen';
  static const String hostHomeScreen = '/hostHomeScreen';
  static const String messageScreen2 = '/messageScreen';
  static const String profileScreen2 = '/profileScreen';
  static const String socialScreen2 = '/socialScreen';
  static const String notificationScreen2 = '/notificationScreen';
  static const String dmLiveScreen = '/dmLiveScreen';
  static const String dmLiveEventDetails = '/dmLiveEventDetails';
  static const String dmUpcomingEventScreen = '/dmUpcomingEventScreen';
  static const String dmUpcomingEventDetails = '/dmUpcomingEventDetails';
  static const String venueFacility = '/venueFacility';
  static const String dmFilter = '/dmFilter';
  static const String confirmBooking = '/confirmBooking';
  static const String confarmation = '/confarmation';
  static const String qrConfirm = '/qrConfirm';
  static const String invitedScreen = '/invitedScreen';
  static const String barRestaurants = '/barRestaurants';
  static const String bar = '/bar';
  static const String restaurants = '/restaurants';
  static const String restaurantDetailsPage = '/restaurantDetailsPage';
  static const String barDetailsPage = '/barDetailsPage';
  static const String galleryScreen = '/galleryScreen';
  static const String updateScreen = '/updateScreen';
  static const String createPostScreen2 = '/createPostScreen';
  static const String createStoryScreen2 = '/createStoryScreen';
  static const String chooseRoleScreen2 = '/chooseRoleScreen';
  static const String ticketsHistory = '/ticketsHistory';
  static const String eventHistory = '/eventHistory';
  static const String dmSocialScreen = '/DmSocialScreen';
  static const String dmMessageScreen = '/DmMessageScreen';
  static const String dmProfileScreen = '/DmProfileScreen';
  static const String dmEditProfileScreen = '/DmEditProfileScreen';
  static const String dmTicketScannerPage = '/DmTicketScannerPage';
  static const String dmPrivacyScreen = '/DmPrivacyScreen';
  static const String dmTermsConditionScreen = '/DmTermsConditionScreen';
  static const String dmChangePasswordScreen = '/DmChangePasswordScreen';
  static const String personProfileScreen = '/PersonProfileScreen';
  static const String dmFollowersScreen = '/DmFollowersScreen';

  static List<GetPage> routes = [
    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: chooseRoleScreen, page: () => ChooseRoleScreen()),
    GetPage(name: forgotScreen, page: () => ForgotScreen()),

    ///===========================Host Part==========================
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: createScreen, page: () => CreateScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: socialScreen, page: () => SocialScreen()),
    GetPage(name: createPostScreen, page: () => CreatePostScreen()),
    GetPage(name: createStoryScreen, page: () => CreateStoryScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: updateProfileScreen, page: () => UpdateProfileScreen()),
    GetPage(name: paymentSetupScreen, page: () => PaymentSetupScreen()),
    GetPage(name: privacyPolicyScreen, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsConditionScreen, page: () => TermsConditionScreen()),
    GetPage(name: languageScreen, page: () => LanguageScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: hostLiveEventDetails, page: () => HostLiveEventDetails()),
    GetPage(name: hostFollowersScreen, page: () => HostFollowersScreen()),
    //GetPage(name: supportFeedbackScreen, page: () => SupportFeedbackScreen()),


    ///===========================Thrill seekers Part==========================
    GetPage(name: favouriteScreen, page: () => FavouriteScreen()),
    GetPage(name: barDetailsPage, page: () => BarDetailsPage()),
    GetPage(name: chooseRoleScreen, page: () => ChooseRoleScreen()),
    GetPage(name: dmHomeScreen, page: () => DmHomeScreen()),
    GetPage(name: messageScreen, page: () => MessageScreen()),
    GetPage(name: socialScreen, page: () => SocialScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
     GetPage(name: dmLiveScreen, page: () => DmLiveEvent()),
     GetPage(name: dmLiveEventDetails, page: () => DmLiveEventDetails()),
     GetPage(name: dmUpcomingEventScreen, page: () => DmUpcomingEventScreen()),
     GetPage(name: dmUpcomingEventDetails, page: () => DmUpcomingDetails()),
    GetPage(name: venueFacility, page: () => VenueFacility()),
    GetPage(name: dmFilter, page: () => DmFilter()),
    GetPage(name: confirmBooking, page: () => ConfirmBooking()),
    GetPage(name: confarmation, page: () => Confirmation()),
    GetPage(name: qrConfirm, page: () => QrConfirm()),
    GetPage(name: invitedScreen, page: () => InvitedScreen()),
    GetPage(name: barRestaurants, page: () => BarResturentScreen()),
    GetPage(name: bar, page: () => NearbyBarScreen()),
    GetPage(name: restaurants, page: () => NearbyRestaurantsScreen()),
    GetPage(name: restaurantDetailsPage, page: () => RestaurantDetailsPage()),
    GetPage(name: barDetailsPage, page: () => BarDetailsPage()),
    GetPage(name: galleryScreen, page: () => GalleryScreen()),
    GetPage(name: updateScreen, page: () => UpdateScreen()),
    GetPage(name: createPostScreen2, page: () => CreatePostScreen()),
    GetPage(name: createStoryScreen2, page: () => CreateStoryScreen()),
    GetPage(name: ticketsHistory, page: () => TicketsHistory()),
    GetPage(name: eventHistory, page: () => EventHistory()),
    GetPage(name: dmSocialScreen, page: () => DmSocialScreen()),
    GetPage(name: dmMessageScreen, page: () => DmMessageScreen()),
    GetPage(name: dmProfileScreen, page: () => DmProfileScreen()),
    GetPage(name: dmEditProfileScreen, page: () => DmEditProfileScreen()),
    GetPage(name: dmTicketScannerPage, page: () => DmTicketScannerPage()),
    GetPage(name: dmPrivacyScreen, page: () => DmPrivacyScreen()),
    GetPage(name: dmTermsConditionScreen, page: () => DmTermsConditionScreen()),
    GetPage(name: dmChangePasswordScreen, page: () => DmChangePasswordScreen()),
    GetPage(name: personProfileScreen, page: () => PersonProfileScreen()),
    GetPage(name: dmFollowersScreen, page: () => DmFollowersScreen()),
  ];
}
