class ApiUrl {
  static const String baseUrl = "https://buy-throw-aids-beatles.trycloudflare.com";
  static const String imageUrl = "http://13.58.33.119:5000/";
  static String socketUrl = "http://13.58.33.119:5000";
  // server url :https://baghdad-spray-bryan-induced.trycloudflare.com
  // local url : http://10.0.60.129:3000/
  ///========================= Authentication =========================
  static const String signUp = "/api/v1/user/create_user";
  static const String verificationOtp = "/api/v1/user/user_verification";
  static const String signIn = "/api/v1/auth/login_user";
  static const String forgotPassword = "/api/v1/user/forgot_password";
  static const String newPassword = "/api/v1/user/reset_password";
  static const String updateProfile = "/api/v1/auth/update_my_profile";
  static const String myProfile = "/api/v1/auth/myprofile";


  ///========================= Host =========================
  static const String createEvent = "/api/v1/event/create_event";
  static  String  updateEvent({required String eventId})=> "/api/v1/event/update_event/$eventId";
  static  String  getEventById({required String eventId})=> "/api/v1/event/find_by_specific_event/$eventId";
  static String allHostEvent({required int page}) => "/api/v1/event/find_my_event_list?page=$page&limit=2";
  static String allHostEventChatRoom({required int page}) => "/api/v1/event_chat_room/find_by_my_event_chatroom?page=$page&limit=10";
  static String allHostEventGroup({required int page}) => "/api/v1/join_group/find_by_my_join_event_Group?page=$page&limit=10";
  static String createPostEvent= "/api/v1/event_post/create_post_event";
  static String getAllPosts({required int page}) =>  "/api/v1/followup/find_by_my_event_social_feed?page=$page&limit=10";

  static const String termsCondition = "/api/v1/setting/find_by_terms_conditions";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String changePassword = "/api/v1/user/change_password";

   //String userId = await SharePrefsHelper.getString(AppConstants.userId);
  ///========================= Host =========================
  static  String  dmLiveEvent({required String searchTime,required int page})=> "/api/v1/event/find_by_all_live_event_filtering?page=$page&limit=2&searchTerm=live&eventDate=$searchTime";
  static  String  dmUpcomingEvent({required int page})=> "/api/v1/event/find_by_all_upcomming_and_past_event?page=$page&limit=10";


  static const String getMap = "/map?sw_lat=18&sw_lng=89&ne_lat=24&ne_lng=92&category_id=68185fc91db8477bce1fade2";
 static String getSchedule({required String consultantId, required String date}) => "/booking/available-slots?consultant_id=68183099ee97f8483fc61a02&date=2025/05/13";
}
