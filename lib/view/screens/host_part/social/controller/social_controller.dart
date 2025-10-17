import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../home/model/creat_event_model.dart';
import '../model/socal_feed_model.dart' hide LiveEventResponse;
import '../model/story_model.dart';

class SocialController extends GetxController {
  // ================== TAB CONTROLLER ==================
  RxInt currentIndex = 0.obs; // Current tab index
  final List<String> tabNames = ["Social Feed", "Group", "Chatroom"];
  RxBool isTextTyped = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataForCurrentTab();
    messageController.addListener(() {
      isTextTyped.value = messageController.text.trim().isNotEmpty;
    });
  }

  void onTabSelected(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      fetchDataForCurrentTab();
    }
  }

  /// Fetch data depending on the current tab
  void fetchDataForCurrentTab() {
    final tabName = tabNames[currentIndex.value];

    switch (tabName) {
      case "Social Feed":
        getAllPosts(isRefresh: true);
        break;
      case "Group":
        getAllGroups(isRefresh: true);
        break;
      case "Chatroom":
        getAllChatRooms(isRefresh: true);
        break;
    }
  }

  // =================== CHATROOM CONTROLLER ===================
  final rxRequestStatus = Status.loading.obs;
  final rxProfileStatus = Status.loading.obs;
  var rxStoryRequestStatus = Status.loading.obs;

  void setRequestStatus(Status status) => rxRequestStatus.value = status;
  void setProfileStatus(Status status) => rxProfileStatus.value = status;

  var chatRooms = <AllEventChatroom>[].obs;
  var totalChatRooms = 0.obs;
  var currentPageChatRoom = 1;
  var totalPagesChatRoom = 1;
  var isLoadingChatRoom = false.obs;
  var isMoreLoadingChatRoom = false.obs;

  Rx<AllEventChatroom> chatroomModel = AllEventChatroom(
    id: '',
    eventId: null,
    hostId: '',
    chatRoomName: '',
    totalMember: 0,
  ).obs;

  Future<void> getAllChatRooms({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPageChatRoom = 1;
      chatRooms.clear();
    }

    if (currentPageChatRoom > totalPagesChatRoom) return;

    // Show loader based on page
    if (currentPageChatRoom == 1) {
      isLoadingChatRoom.value = true;
    } else {
      isMoreLoadingChatRoom.value = true;
    }

    try {
      var response = await ApiClient.getData(
        ApiUrl.allHostEventChatRoom(page: currentPageChatRoom),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];

        var meta = data['meta'];
        totalPagesChatRoom = meta['totalPage'];
        totalChatRooms.value = meta['total'];

        var chatroomList = data['all_event_chatroom'] as List;
        var newChatRooms =
            chatroomList.map((e) => AllEventChatroom.fromJson(e)).toList();

        chatRooms.addAll(newChatRooms);

        currentPageChatRoom++; // increment page for next fetch
        setRequestStatus(Status.completed);
      } else {
        setRequestStatus(Status.error);
        Get.snackbar("Error", "Failed to load chatRooms.");
      }
    } catch (e) {
      setRequestStatus(Status.error);
      debugPrint("Parsing error: $e");
    } finally {
      isLoadingChatRoom.value = false;
      isMoreLoadingChatRoom.value = false;
    }
  }

// =================== GROUP CONTROLLER ===================
  var groups = <GroupModel>[].obs;

  /// Meta
  var totalGroups = 0.obs;
  var currentPageGroup = 1;
  var totalPagesGroup = 1;
  var isLoadingGroup = false.obs;
  var isMoreLoadingGroup = false.obs;

  Rx<GroupModel> groupModel = GroupModel(
          id: '', eventId: null, hostId: '', groupName: '', totalMember: 0)
      .obs;

  Future<void> getAllGroups({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPageGroup = 1;
      groups.clear();
    }

    if (currentPageGroup > totalPagesGroup) return;

    // Loader
    if (currentPageGroup == 1) {
      isLoadingGroup.value = true;
    } else {
      isMoreLoadingGroup.value = true;
    }
    try {
      var response = await ApiClient.getData( ApiUrl.allHostEventGroup(page: currentPageGroup),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];

        var meta = data['meta'];
        totalPagesGroup = meta['totalPage'];
        totalGroups.value = meta['total'];

        var groupList = data['all_my_join_event'] as List;
        var newGroups = groupList.map((e) => GroupModel.fromJson(e)).toList();

        groups.addAll(newGroups);

        currentPageGroup++;
        setRequestStatus(Status.completed);
      } else {
        setRequestStatus(Status.error);
        Get.snackbar("Error", "Failed to load groups.");
      }
    } catch (e) {
      setRequestStatus(Status.error);
      debugPrint("Parsing error: $e");
    } finally {
      isLoadingGroup.value = false;
      isMoreLoadingGroup.value = false;
    }
  }

// =================== SOCIAL FEED VARIABLES ===================
  var taggedPeople = <String>[].obs;
  var isCreatingPost = false.obs;

  /// Add a tag to the list
  void addTag() {
    if (tagController.text.isNotEmpty &&
        !taggedPeople.contains(tagController.text.trim())) {
      taggedPeople.add(tagController.text.trim());
      tagController.clear();
    }
  }

  /// Remove a tag from the list
  void removeTag(String tag) {
    taggedPeople.remove(tag);
  }


  // =================== CREATE POST CONTROLLER ===================
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  /// Method to pick an image from the gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }


  /// Controllers for text fields
  final captionController = TextEditingController();
  final tagController = TextEditingController();
  final locationNameController = TextEditingController();

  // Main method to create the post
  Future<void> createPost() async {
    try {
      if (selectedImage.value == null && captionController.text.isEmpty) {
        showCustomSnackBar("Please upload a photo or video or caption");
        return;
      }
      isCreatingPost.value = true;

      Map<String, dynamic> body = {
        "caption": captionController.text,
        "content": locationNameController.text,
        "tag_people": taggedPeople.toList(),
      };

      dynamic response;
      if (selectedImage.value != null) {
        response = await ApiClient.postMultipartData(ApiUrl.createPostEvent,
          {
            "data": jsonEncode(body),
          },
          multipartBody: [
            MultipartBody("file", selectedImage.value!),
          ],
        );
      }
      else {
        response = await ApiClient.postData(ApiUrl.createPostEvent, jsonEncode(body),);
      }
      isCreatingPost.value = false;
      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      debugPrint("Response: ${jsonEncode(jsonResponse)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Post created successfully!",
          isError: false,
        );
        Get.back();
        getAllPosts(isRefresh: true);
        resetCreatePostFields();
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Create post failed",
          isError: true,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isCreatingPost.value = false;
    }
  }

  // Clears all fields and selections on the create post screen
  void resetCreatePostFields() {
    selectedImage.value = null;
    captionController.clear();
    locationNameController.clear();
    tagController.clear();
    taggedPeople.clear();
    messageController.clear();
    isTextTyped.value = false;
  }

  // =================== GET ALL Story Post API ===================
  final messageController = TextEditingController();

  /// Main method to create the post
  Future<void> createStory() async {
    try {
      isCreatingPost.value = true;

      Map<String, dynamic> body = {
        "message": messageController.text,
      };

      dynamic response;
      if (selectedImage.value != null) {
        response = await ApiClient.postMultipartData(
          ApiUrl.createStory,
          {"data": jsonEncode(body)},
          multipartBody: [MultipartBody("file", selectedImage.value!)],
        );
      } else {
        response = await ApiClient.postData(
          ApiUrl.createStory,
          jsonEncode(body),
        );
      }

      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      debugPrint("Response: ${jsonEncode(jsonResponse)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Post created successfully!",
          isError: false,
        );

        // 🔹 Important: clear previous stories before fetching new ones
        stories.clear(); // assuming `stories` is your RxList of story posts

        // 🔹 fetch updated stories from server
        await getAllStories(isRefresh: true);

        // 🔹 reset fields
        resetCreateStoryFields();

        // 🔹 then go back
        Get.back();
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Create post failed",
          isError: true,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isCreatingPost.value = false;
    }
  }

  /// Clears all fields and selections on the create post screen
  void resetCreateStoryFields() {
    selectedImage.value = null;
    messageController.clear();
  }

// =================== GET ALL Follower Post API ===================

  var posts = <PostModel>[].obs;
  var stories = <StoryModel>[].obs;
  var isLoadingPosts = true.obs;
  var isMoreLoadingPosts = false.obs;
  var currentPagePosts = 1;
  var totalPagesPosts = 1;
  var isLoadingStories = true.obs;
  var isMoreLoadingStories = false.obs;
  var currentPageStories = 1;
  var totalPagesStories = 1;
  RxBool isClicked = false.obs;
  void toggleFollow() {
    isClicked.value = !isClicked.value;
    debugPrint("Follow button clicked: ${isClicked.value}");
  }

  Future<void> fetchInitialPost() async {
    currentPagePosts = 1;
    totalPagesPosts = 1;
    currentPageStories = 1;
    totalPagesStories = 1;
    posts.clear();
    stories.clear();
    await getAllPosts();
    await getAllStories();
  }

  String getUserName(String fullName) {
    if (fullName.isEmpty) return "";
    String lowerName = fullName.toLowerCase();
    return lowerName.split(" ").first;
  }

  Future<void> getAllPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPagePosts = 1;
      posts.clear();
      setRequestStatus(Status.loading);
    } else {
      if (currentPagePosts > totalPagesPosts) return;

      if (currentPagePosts == 1) {
        isLoadingPosts.value = true;
        setRequestStatus(Status.loading);
      } else {
        isMoreLoadingPosts.value = true;
      }
    }

    try {
      String savedId = await SharePrefsHelper.getString('selectedEventId');
      String page = await SharePrefsHelper.getString('pageName');
      debugPrint("{$savedId,$page}");
      final response = await ApiClient.getData(ApiUrl.getAllPosts(page: currentPagePosts));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.body['data'];
        var paginationData = responseData['pagination'];
        var postList = responseData['data'] as List;

        var newPosts =
            postList.map((postJson) => PostModel.fromJson(postJson)).toList();

        if (isRefresh || currentPagePosts == 1) {
          posts.assignAll(newPosts);
        } else {
          posts.addAll(newPosts);
        }

        currentPagePosts = paginationData['page'];
        totalPagesPosts = paginationData['totalPages'];

        setRequestStatus(Status.completed);
      } else {
        setRequestStatus(Status.error);
        Get.snackbar("Error", "Failed to load social feed.");
      }
    } catch (e) {
      setRequestStatus(Status.error);
      debugPrint("Error fetching posts: $e");
    } finally {
      isMoreLoadingPosts.value = false;
      isLoadingPosts.value = false;
    }
  }

// =================== GET ALL Follower Story API ===================

  Future<void> getAllStories({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPageStories = 1;
      stories.clear();
      rxStoryRequestStatus.value = Status.loading;
    } else {
      if (currentPageStories > totalPagesStories) return;
      if (currentPageStories == 1) {
        isLoadingStories.value = true;
        rxStoryRequestStatus.value = Status.loading;
      } else {
        isMoreLoadingStories.value = true;
      }
    }

    try {
      final response = await ApiClient.getData(
          ApiUrl.getAllStories(page: currentPageStories));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.body['data'];
        var feedList = responseData['data']['feeds'] as List? ?? [];

        var validFeeds = feedList
            .map((e) => FeedModel.fromJson(e as Map<String, dynamic>))
            .where((feed) =>
                (feed.content != null && feed.content!.isNotEmpty) ||
                (feed.message != null && feed.message!.isNotEmpty))
            .toList();

        if (validFeeds.isEmpty) {
          if (isRefresh || currentPageStories == 1) {
            stories.clear();
          }
          rxStoryRequestStatus.value = Status.completed;
          return;
        }

        var storyModels = [StoryModel(feeds: validFeeds)];

        if (isRefresh || currentPageStories == 1) {
          stories.assignAll(storyModels);
        } else {
          stories.addAll(storyModels);
        }

        currentPageStories++;
        rxStoryRequestStatus.value = Status.completed;
      } else {
        rxStoryRequestStatus.value = Status.error;
      }
    } catch (e) {
      rxStoryRequestStatus.value = Status.error;
      debugPrint("Error fetching stories: $e");
    } finally {
      isMoreLoadingStories.value = false;
      isLoadingStories.value = false;
    }
  }


// =================== Social post React Logic ===================
//(Mehedi & Eusof) vai Don't cut this code before finalizing the project

 // RxBool isClicked = false.obs;
 //  void togglePostLove({required bool isClicked}) {
 //    isClicked = !isClicked;
 //    debugPrint("React clicked: ${isClicked}");
 //  }

  Future<void> toggleReact(String postId) async {
    try {
      final response = await http.post(Uri.parse("${ApiUrl.baseUrl}${ApiUrl.reactPost}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${ApiClient.bearerToken}",
        },
        body: jsonEncode({"eventpostId": postId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          await getAllPosts(isRefresh: true);
        } else {
          Get.snackbar("Error", data["message"] ?? "Something went wrong");
        }
      } else {
        Get.snackbar("Error", "Failed to react on post");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
/*  Future<void> toggleReact(PostModel post) async {

    post.isReacted.value = !post.isReacted.value;
    if (post.isReacted.value) {
      post.react.value++;
    } else {
      if (post.react.value > 0) {
        post.react.value--;
      }
    }

    try {
      final response = await ApiClient.postData(
        ApiUrl.reactPost,
        jsonEncode({"eventpostId": post.id}),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        Get.snackbar("Error", "Failed to sync reaction. Please try again.");
        post.isReacted.value = !post.isReacted.value;
        if (post.isReacted.value) {
          post.react.value++;
        } else {
          if (post.react.value > 0) {
            post.react.value--;
          }
        }
      }


    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
      post.isReacted.value = !post.isReacted.value;
      if (post.isReacted.value) {
        post.react.value++;
      } else {
        if (post.react.value > 0) {
          post.react.value--;
        }
      }
    }
  }*/

// =================== Social post comment Logic ===================
  var comments = <AllCommentPost>[].obs;
  var isCommentLoading = true.obs;
  var isMoreCommentLoading = false.obs;
//get comment
  Future<void> getComment() async {
    try {
      String postId = await SharePrefsHelper.getString('selectedPostId');
      final response = await ApiClient.getData(ApiUrl.getComment(postId: postId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = LiveEventResponse2.fromJson(response.body);
        final newComments = model.data?.allCommentPost ?? [];

        comments.clear();
        comments.addAll(newComments);
        setRequestStatus(Status.completed);
      } else {
        setRequestStatus(Status.error);
        Get.snackbar("Error", "Failed to load live event comments");
      }
    } catch (e, stack) {
      setRequestStatus(Status.error);
      debugPrint("Error fetching live comments: $e");
      debugPrint(stack.toString());
    } finally {
      isMoreCommentLoading.value = false;
      isCommentLoading.value = false;
    }
  }



  //post
  Rx<TextEditingController> commentController = TextEditingController().obs;
  RxBool isPostingComment = false.obs;

  Future<void> postComment({required String postId}) async {
   // String postId = await SharePrefsHelper.getString('selectedPostId');
    final commentText = commentController.value.text.trim();
    if (commentText.isEmpty) return;
    isPostingComment.value = true;
    update();

    try {
      Map<String, dynamic> body = {
        "comment": commentText,
        "eventpostId": postId,
      };

      final response = await ApiClient.postData(
        ApiUrl.commentEvent,
        jsonEncode(body),
      );

      final jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        commentController.value.clear();
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Comment posted successfully!",
          isError: false,
        );
        await getComment();
        await getAllPosts(isRefresh: false);
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Failed to post comment",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Error posting comment: $e", isError: true);
      debugPrint(" Live comment error: $e");
    } finally {
      isPostingComment.value = false;
      update();
    }
  }


  //Reply comment
  RxBool isReplyingComment = false.obs;

  Future<void> postReply({required String parentCommentId, required String replyText}) async {

    final trimmedReply = replyText.trim();
    if (trimmedReply.isEmpty) {
      showCustomSnackBar("Please write a reply first.", isError: true);
      return;
    }
    isReplyingComment.value = true;

    try {
      Map<String, dynamic> body = {
        "commentEventPostId": parentCommentId,
        "comment": trimmedReply,
      };

      final response = await ApiClient.postData(ApiUrl.replyComment, jsonEncode(body));

      final jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Reply successful!",
          isError: false,
        );
        await getComment();
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Failed to reply comment",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Error replying comment: $e", isError: true);
      debugPrint("Reply comment error: $e");
    } finally {
      isReplyingComment.value = false;
    }
  }

  //Get replied
  RxBool isReplyLoading = false.obs;
  RxMap<String, List<dynamic>> commentReplies = <String, List<dynamic>>{}.obs;

  Future<void> getReplies(String commentId) async {
    isReplyLoading.value = true;
    try {
      final response = await ApiClient.getData(
        ApiUrl.getRepliesByCommentId(commentId),
      );

      final jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        commentReplies[commentId] = jsonResponse['data']['reply'] ?? [];
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Failed to load replies",
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("Get replies error: $e");
      showCustomSnackBar("Error fetching replies: $e", isError: true);
    } finally {
      isReplyLoading.value = false;
    }
  }



// =================== Social  Share Post ===================
  RxBool isShareLoading = false.obs;

  Future<void> sharePostAndCount(PostModel post) async {
    try {
      Map<String, dynamic> body = {
        "eventpostId": post.id,
      };

      final response = await ApiClient.postData(
        ApiUrl.postShare,
        jsonEncode(body),
      );

      final jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Share successfully!",
          isError: false,
        );
        await getAllPosts(isRefresh: false);
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Failed to share",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Error to share: $e", isError: true);
      debugPrint(" Share  error: $e");
    } finally {
      isShareLoading.value = false;
      update();
    }
  }


}

// ===================== Extension =====================
extension StoryGrouping on SocialController {
  // Map userId → List<FeedModel>
  Map<String, List<FeedModel>> get storiesGroupedByUser {
    final Map<String, List<FeedModel>> grouped = {};

    for (var story in stories) {
      for (var feed in story.feeds) {
        // Skip empty/invalid feeds
        if ((feed.content == null || feed.content!.isEmpty) &&
            (feed.message == null || feed.message!.isEmpty)) {
          continue; // skip this feed
        }

        final userId = feed.userId;
        if (!grouped.containsKey(userId)) {
          grouped[userId] = [];
        }
        grouped[userId]!.add(feed);
      }
    }

    return grouped;
  }
}
