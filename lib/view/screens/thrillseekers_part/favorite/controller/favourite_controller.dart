import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../host_part/social/model/socal_feed_model.dart';
import '../model/favourite_details_model.dart';
import '../model/favourite_model.dart';
import '../model/my_memories_event_model.dart' hide Meta;

class FavouriteController extends GetxController {
  /// To store the selected image file
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  /// To store the selected video file
  var selectedVideo = Rx<File?>(null);
  var videoThumbnail = Rx<File?>(null); // For video preview image

/*
  /// Method to pick an image from the gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }*/

  /// Pick image
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      selectedVideo.value = null; // reset video if image selected
      videoThumbnail.value = null;
    }
  }

  /// Pick video and generate thumbnail
  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 10),
    );

    if (video != null) {
      selectedVideo.value = File(video.path);
      selectedImage.value = null; // reset image if video selected

      final thumbPath = await _generateVideoThumbnail(video.path);
      if (thumbPath != null) {
        videoThumbnail.value = File(thumbPath);
      }
    }
  }

  /// Generate thumbnail from video file
  Future<String?> _generateVideoThumbnail(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    final thumbPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 75,
    );
    return thumbPath;
  }

  RxInt selectedIndex = 0.obs;
  final rxFavouriteNonEventStatus = Status.loading.obs;

  void setFavouriteNonEventStatus(Status status) =>
      rxFavouriteNonEventStatus.value = status;

  RxList<MyFavoriteEvent> favouriteEvents = <MyFavoriteEvent>[].obs;
  var isLoading = true.obs;
  var isMoreLoading = false.obs;
  int currentPage = 1;
  int totalPages = 1;

  /// ==========================
  /// Fetch Favourite Events API
  /// ==========================
  Future<void> getFavouriteNonEvent() async {
    if (currentPage > totalPages) return;

    if (currentPage == 1) {
      isLoading.value = true;
      setFavouriteNonEventStatus(Status.loading);
    } else {
      isMoreLoading.value = true;
    }

    try {
      final response = await ApiClient.getData(
        ApiUrl.getFavouriteList(page: currentPage),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = MyFavoriteEventModel.fromJson(response.body);
        final newEvents = model.data?.myFavoriteEvent ?? [];
        final meta = model.data?.meta;
        totalPages =
        meta != null && meta.totalPage != null ? meta.totalPage! : 1;

        if (currentPage == 1) favouriteEvents.clear();
        favouriteEvents.addAll(newEvents);

        currentPage++;
        setFavouriteNonEventStatus(Status.completed);
      } else {
        setFavouriteNonEventStatus(Status.error);
        Get.snackbar("Error", "Failed to load favourite events");
      }
    } catch (e, stack) {
      debugPrint("Error fetching favourite events: $e");
      debugPrint(stack.toString());
      setFavouriteNonEventStatus(Status.error);
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  /// ==========================
  /// Toggle Favourite Locally + API Sync
  /// ==========================
  void toggleFavorite(MyFavoriteEvent event) {
    final index = favouriteEvents.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      // Toggle favourite status locally
      // final updatedEvent = favouriteEvents[index].copyWith(
      //   isFavorite: !(favouriteEvents[index].isFavorite ?? false),
      // );
      // favouriteEvents[index] = updatedEvent;

      // Optionally update on server
      // _updateFavoriteOnServer(event.id!, updatedEvent.isFavorite ?? false);
    }
  }

  Future<void> deleteFavorite({required String deleteId}) async {
    try {
      final response = await ApiClient.deleteData(
        ApiUrl.deleteFavouriteList(deleteId: deleteId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Favorite delete successfully");
        await getFavouriteNonEvent();

        favouriteEvents.removeWhere((event) => event.id == deleteId);
        favouriteEvents.refresh();

        showCustomSnackBar(
          "Favorite deleted successfully!",
          isError: false,
        );
      } else {
        debugPrint("Failed to delete favorite");
        showCustomSnackBar("Failed to delete favorite", isError: true);
      }
    } catch (e) {
      debugPrint("Error deleting favorite: $e");
      showCustomSnackBar("Something went wrong!", isError: true);
    }
  }




  // Future<void> updateFavoriteOnServer(String deleteId, bool isFavorite) async {
  //   try {
  //     final endpoint = isFavorite
  //         ? ApiUrl.addFavouriteList(addId: deleteId)
  //         : ApiUrl.deleteFavouriteList(deleteId: deleteId);
  //
  //     final response = await ApiClient.postData(endpoint, {});
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       debugPrint("Favorite updated successfully");
  //     } else {
  //       debugPrint("Failed to update favorite status on server");
  //     }
  //   } catch (e) {
  //     debugPrint("Error updating favorite status: $e");
  //   }
  // }

  // GALLERY - CREATE & MANAGE POSTS
  final List<String> tabNames = ["All", "Photo", "Video"];

  final TextEditingController contentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var isPostingFavoriteContent = false.obs;
  var isLiked = <String, bool>{}.obs;

  Future<void> createFavoritePost(String favoriteEventId) async {
    // check if neither image nor video selected
    if (selectedImage.value == null && selectedVideo.value == null) {
      Get.snackbar("Error", "Please select a photo or video first.");
      return;
    }
    if (contentController.text.isEmpty) {
      Get.snackbar("Error", "Please write a caption/content.");
      return;
    }

    isPostingFavoriteContent.value = true;

    try {
      // determine which file is selected (image or video)
      File? fileToUpload = selectedImage.value ?? selectedVideo.value;

      // detect file type from extension
      String fileExtension = fileToUpload!
          .path
          .split('.')
          .last
          .toLowerCase();
      String contentType = (fileExtension == 'mp4' ||
          fileExtension == 'mov' ||
          fileExtension == 'avi')
          ? 'video'
          : 'photo';

      Map<String, String> body = {
        "favoriteeventId": favoriteEventId,
        "content": "Photo or Video",
        "contentType": contentType,
        "description": contentController.text,
      };

      final response = await ApiClient.postMultipartData(
        ApiUrl.createGalleryPost,
        {"data": jsonEncode(body)},
        multipartBody: [MultipartBody("file", fileToUpload)],
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Gallery Post created successfully!",
          isError: false,
        );
        resetPostFields();
        getMyMemories();
        Get.back();
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Gallery Create post failed",
          isError: true,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isPostingFavoriteContent.value = false;
    }
  }

  // /// METHOD 4: React to a post (Like/Unlike)
  // void reactToPost(String postId) {
  //   isLiked[postId] = !(isLiked[postId] ?? false);
  //   isLiked.refresh(); // UI আপডেট করার জন্য
  //
  //   // সার্ভারে লাইক স্ট্যাটাস পাঠানোর জন্য API কল
  //   // উদাহরণ:
  //   // ApiClient.postData(ApiUrl.reactToPost, {
  //   //   "postId": postId,
  //   //   "isLiked": isLiked[postId]
  //   // });
  //   debugPrint("Post $postId is Liked: ${isLiked[postId]}");
  // }

  void resetPostFields() {
    selectedImage.value = null;
    selectedVideo.value = null;
    videoThumbnail.value = null;
    contentController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    contentController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

// Controller variables
  RxList<MyMemoriesEvent> myMemoriesList = <MyMemoriesEvent>[].obs;
  RxInt selectedTabIndex = 0.obs;
  var isLoadingMemories = false.obs;
  var isMoreMemoriesLoading = false.obs;
  int currentPageMemories = 1;
  int totalPagesMemories = 1;
  String currentFilter = "all";

  final rxFavouriteMemoriesStatus = Status.loading.obs;

  void setFavouriteMemoriesStatus(Status status) =>
      rxFavouriteMemoriesStatus.value = status;

// Get memories posts
  Future<void> getMyMemories({String? contentType, int? page}) async {
    if (contentType != null) currentFilter = contentType;
    final int pageToFetch = page ?? currentPageMemories;
    if (page == null && currentPageMemories > totalPagesMemories) return;

    if (page == null && currentPageMemories == 1) {
      isLoadingMemories.value = true;
      setFavouriteMemoriesStatus(Status.loading);
    } else if (page == null) {
      isMoreMemoriesLoading.value = true;
    }

    try {
      final response = currentFilter == "all"
          ? await ApiClient.getData(ApiUrl.getGalleryPosts(page: pageToFetch))
          : await ApiClient.getData(ApiUrl.getGalleryPostFilter(
          page: pageToFetch, filter: currentFilter));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = MyMemoriesEventResponse.fromJson(response.body);
        final List<MyMemoriesEvent> newMemories =
            model.data.myMemoriesEvent ?? [];

        final meta = model.data.meta;
        totalPagesMemories = meta.total ?? 1;

        if (page == null) {
          if (pageToFetch == 1) myMemoriesList.clear();
          myMemoriesList.addAll(newMemories);
          currentPageMemories++;
        } else {

          final startIndex = (pageToFetch - 1) * newMemories.length;
          if (startIndex < myMemoriesList.length) {
            final endIndex = (startIndex + newMemories.length)
                .clamp(0, myMemoriesList.length);
            myMemoriesList.replaceRange(startIndex, endIndex, newMemories);
          } else {
            myMemoriesList.addAll(newMemories);
          }
        }

        setFavouriteMemoriesStatus(Status.completed);
      } else {
        setFavouriteMemoriesStatus(Status.error);
        Get.snackbar("Error", "Failed to load memories");
      }
    } catch (e, stack) {
      debugPrint("Error fetching memories: $e");
      debugPrint(stack.toString());
      setFavouriteMemoriesStatus(Status.error);
    } finally {
      isLoadingMemories.value = false;
      isMoreMemoriesLoading.value = false;
    }
  }



// Tab change handler
  void changeTab(int index) {
    selectedTabIndex.value = index;

    // Reset pagination
    currentPageMemories = 1;
    totalPagesMemories = 1;

    // Clear existing list
    myMemoriesList.clear();

    // Fetch based on tab
    if (index == 0) {
      getMyMemories(contentType: "all"); // All
    } else if (index == 1) {
      getMyMemories(contentType: "photo");
    } else if (index == 2) {
      getMyMemories(contentType: "video");
    }
  }

  //------Get Favourite Item-----//
  RxInt index = 0.obs;

  var rxFavouriteDetails = Status.loading.obs;

  void setFavouriteDetailsStatus(Status status) =>
      rxFavouriteDetails.value = status;

  var isLoadingDetails = true.obs;
  var isMoreLoadingDetails = false.obs;

  Rxn<EventData> favouriteDetails = Rxn<EventData>();

  /// Fetch favourite event details by ID
  Future<void> getFavouriteDetails({required String specificId}) async {
    setFavouriteDetailsStatus(Status.loading);
    isLoadingDetails.value = true;

    try {
      final response = await ApiClient.getData(
        ApiUrl.getFavouriteDetails(specificId: specificId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonBody = response.body is String
            ? jsonDecode(response.body)
            : response.body;
        debugPrint("........${response.body}");
        final model = FavoriteEventModel.fromJson(jsonBody);

        if (model.data != null) {
          favouriteDetails.value = model.data;
          setFavouriteDetailsStatus(Status.completed);
        } else {
          setFavouriteDetailsStatus(Status.error);
        }
      } else {
        setFavouriteDetailsStatus(Status.error);
        Get.snackbar("Error", "Failed to load favourite event details");
      }
    } catch (e, stack) {
      debugPrint("Error fetching favourite details: $e");
      debugPrint(stack.toString());
      setFavouriteDetailsStatus(Status.error);
    } finally {
      isLoadingDetails.value = false;
      isMoreLoadingDetails.value = false;
    }
  }



  // Gallery post react logic

  RxBool isClicked = false.obs;
  void toggleLove() {
    isClicked.value = !isClicked.value;
    debugPrint("Follow button clicked: ${isClicked.value}");
  }
  RxBool isLoveLoading = false.obs;
  Future<void> loveCount({required String favoriteEventId, required bool isLove, required int currentPage,}) async {
    try {
      final body = {
        "uploadMemorieSeventId": favoriteEventId,
        "isLove": isLove,
      };

      final response =
      await ApiClient.postData(ApiUrl.loveEmoji, jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar("Reaction updated", isError: false);

        // ✅ কেবল ওই page রিফ্রেশ করো
        await getMyMemories(
          contentType: currentFilter,
          page: currentPage,
        );

        update();
      } else {
        showCustomSnackBar("Failed to update", isError: true);
      }
    } catch (e) {
      showCustomSnackBar("Error: $e", isError: true);
    } finally {
      isLoveLoading.value = false;
      update();
    }
  }




  ///------ Nearby Bar Location----- ///
  RxInt selectedNearIndex = 0.obs;
  final rxNonEvenNeartStatus = Status.loading.obs;

  void setNearNonEventStatus(Status status) =>
      rxNonEvenNeartStatus.value = status;

  RxList<MyFavoriteEvent> favouriteNearNonEvents = <MyFavoriteEvent>[].obs;
  var isNearNonEventsLoading = true.obs;
  var isMoreNearNonEventsLoading = false.obs;
  int currentPageNearNonEvents = 1;
  int totalPagesNearNonEvents = 1;

  Future<void> getNearNonEvent({required String lat, required String lon, required String type}) async {
    if (currentPageNearNonEvents > totalPagesNearNonEvents) return;

    if (currentPageNearNonEvents == 1) {
      isNearNonEventsLoading.value = true;
      setFavouriteNonEventStatus(Status.loading);
    } else {
      isMoreNearNonEventsLoading.value = true;
    }

    try {
      final response = await ApiClient.getData(ApiUrl.nonEventNearbyGet(lat: lat, lon: lon, type: type),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = MyFavoriteEventModel.fromJson(response.body);
        final newEvents = model.data?.myFavoriteEvent ?? [];
        final meta = model.data?.meta;
        totalPagesNearNonEvents =
        meta != null && meta.totalPage != null ? meta.totalPage! : 1;

        if (currentPageNearNonEvents == 1) favouriteNearNonEvents.clear();
        favouriteNearNonEvents.addAll(newEvents);

        currentPageNearNonEvents++;
        setFavouriteNonEventStatus(Status.completed);
      } else {
        setFavouriteNonEventStatus(Status.error);
        Get.snackbar("Error", "Failed to load favourite events");
      }
    } catch (e, stack) {
      debugPrint("Error fetching favourite events: $e");
      debugPrint(stack.toString());
      setFavouriteNonEventStatus(Status.error);
    } finally {
      isNearNonEventsLoading.value = false;
      isMoreNearNonEventsLoading.value = false;
    }
  }

}