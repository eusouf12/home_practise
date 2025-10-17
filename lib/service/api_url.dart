class ApiUrl {
  static const String baseUrl = "https://attending-marble-ron-spectrum.trycloudflare.com";
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
  static String createStory= "/api/v1/social_feed_route/social_feed";
  static String getAllPosts({required int page}) =>  "/api/v1/followup/find_by_my_event_social_feed?page=$page&limit=10";
  static String getAllStories({required int page}) => "/api/v1/social_feed_route/find_my_follow_waie_social_feed?page=$page&limit=10";
  //React
  static String reactPost= "/api/v1/event_social_post/react_event";
  //Comment
  static String commentEvent= "/api/v1/event_social_post/event_comment";
  //Get Comment
  static  String  getComment({required String postId})=> "/api/v1/event_post_reply/find_by_specific_event_comment_filtering/$postId";
  //Comment reply
  static  String  replyComment= "/api/v1/event_post_reply/reply";
  //Get reply
  static String getRepliesByCommentId(String commentId) => "/api/v1/event_post_reply/find_by_specific_event_reply_filtering/$commentId";
  //Share
  static String postShare= "/api/v1/event_social_post/event_share";
  //Create memories post
  static String createGalleryPost= "/api/v1/memories_event/memories_post_event";
  //Get memories post
  static String getGalleryPosts({required int page})=> "/api/v1/memories_event/find_my_upload_memories_event?page=$page&limit=10";
  static String getGalleryPostFilter({required  int page, required String filter})=> "/api/v1/memories_event/find_my_upload_memories_event?contentType=$filter&page=$page&limit=10";


  static const String termsCondition = "/api/v1/setting/find_by_terms_conditions";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String changePassword = "/api/v1/user/change_password";

   //String userId = await SharePrefsHelper.getString(AppConstants.userId);
  ///========================= Dm  =========================
  static  String  dmLiveEvent({required String searchTime,required int page})=> "/api/v1/event/find_by_all_live_event_filtering?page=$page&limit=2&searchTerm=live&eventDate=$searchTime";
  static  String  liveEventDetails({required String eventId})=> "/api/v1/event/find_by_specific_event/$eventId";
  static  String  liveEventCreatePost = "/api/v1/event_post/create_post_event";
  static  String  liveEventGetPost({required String eventId,required int page})=> "/api/v1/event_post/find_by_all_specific_event_post_list/$eventId?page=1&limit=page=?$page";
  static  String  postLiveComment = "/api/v1/event_social_post/live_event_comment";
  static  String  getLiveComment({required String eventId})=> "/api/v1/event_social_post/find_by_specific_live_comment/$eventId";
  static  String  dmUpcomingEvent({required int page})=> "/api/v1/event/find_by_all_upcomming_and_past_event?page=$page&limit=10";
  static  String  getFavouriteList({required int page})=>  "/api/v1/favorite_event/find_by_all_my_favorite_event?page=$page&limit=10";
  static  String  deleteFavouriteList({required String deleteId})=> "/api/v1/favorite_event/delete_my_favorite_event/$deleteId";
  static  String  addFavouriteList({required String addId})=> "/api/v1/favorite_event/delete_my_favorite_event/$addId";
  static String paymentMethod= "/api/v1/payment/payment_onboarding";
  static String loveEmoji= "/api/v1/memories_event/love_eemoji_memories_event_count";
  static String getFavouriteDetails({required String specificId}) => "/api/v1/favorite_event/find_by_specific_my_favorite_event/$specificId";
  static  String  nonEventNearbyGet({required String lat, required String lon, required String type})=> "/api/v1/event/nearest_location_ways_non_event?latitude=$lat&longitude=$lon&type=$type";


  // map
  static const String getMap = "/map?sw_lat=18&sw_lng=89&ne_lat=24&ne_lng=92&category_id=68185fc91db8477bce1fade2";



}
