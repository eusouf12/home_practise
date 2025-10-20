import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../host_part/event/controller/event_controller.dart';
import '../../../../host_part/home/model/creat_event_model.dart';
import '../../view/papal_payment_page/papal_payment_page.dart';
import '../../widget/custom_map_icon/custom_markers.dart';

class DmHomeController extends GetxController {

  /// To store the selected image file
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  /// Method to pick an image from the gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  //Follow === Not done yet
  // RxMap<String, bool> isFollowedMap = <String, bool>{}.obs;
  // void toggleFollow(String postId) {
  //   bool current = isFollowedMap[postId] ?? false;
  //   isFollowedMap[postId] = !current;
  // }

  RxInt selectedIndex = 0.obs;
  final rxRequestStatus = Status.loading.obs;
  final rxLiveEventRequestStatus = Status.loading.obs;
  final rxUpcomingEventRequestStatus = Status.loading.obs;
  void setRequestStatus(Status status) => rxRequestStatus.value = status;
  void setUpcomingRequestStatus(Status status) => rxUpcomingEventRequestStatus.value = status;
  void setLiveEventRequestStatus(Status status) => rxLiveEventRequestStatus.value = status;

  var events = <Event>[].obs;
  var upcomingEvents = <Event>[].obs;
  Rx<CreateEventModel?> specificEvent = Rx<CreateEventModel?>(null);
  var isLoading = true.obs;
  var isLoading2 = true.obs;
  var isMoreLoading = false.obs;
  var isMoreLoading2 = false.obs;
  var totalEvents = 0.obs;
  int currentPage = 1;
  int totalPages = 1;


  Future<void> fetchInitialEvents() async {
    currentPage = 1;
    totalPages = 1;
    events.clear();
    upcomingEvents.clear();
    await fetchLiveEvents();
    await fetchUpcomingEvents();
  }
 // Get live events
  Future<void> fetchLiveEvents() async {
    if (currentPage > totalPages) return;

    if (currentPage == 1) {
      isLoading2.value = true;
      setRequestStatus(Status.loading);
    } else {
      isMoreLoading2.value = true;
    }

    try {
      //DateTime.now().toIso8601String().split('T')[0]
      final response = await ApiClient.getData(ApiUrl.dmLiveEvent(searchTime: "01-10-2025",page: currentPage ),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];

        // Meta
        totalPages = data['meta']['totalPage'];
        totalEvents.value = data['meta']['total'];

        // Parse events
        var myEventList = data['myEvent'] as List;
        var newEvents = myEventList.map((e) => Event.fromJson(e)).toList();

        if (currentPage == 1) events.clear();
        events.addAll(newEvents);

        currentPage++;
        setLiveEventRequestStatus(Status.completed);
      } else {
        setLiveEventRequestStatus(Status.error);
      }
    } catch (e) {
      print("Error fetching live events: $e");
      setLiveEventRequestStatus(Status.error);
    } finally {
      isLoading2.value = false;
      isMoreLoading2.value = false;
    }
  }

  // Get live events details
  int ticketCount = 0;
  Future<void> getLiveEventDetails() async {
    final int ticket =  await SharePrefsHelper.getInt('totalTicket');
    ticketCount = ticket;
    try {
      String liveEventId = await SharePrefsHelper.getString('selectedEventId');
      final response = await ApiClient.getData(ApiUrl.liveEventDetails(eventId: liveEventId) );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        specificEvent.value = CreateEventModel.fromJson(data);
        setLiveEventRequestStatus(Status.completed);
      } else {
        setLiveEventRequestStatus(Status.error);
      }
    } catch (e) {
      print("Error fetching live events details: $e");
      setLiveEventRequestStatus(Status.error);
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  // tag people
   var taggedPeople = <String>[].obs;
    void addTag() {
      if (tagController.text.isNotEmpty &&
          !taggedPeople.contains(tagController.text.trim())) {
        taggedPeople.add(tagController.text.trim());
        tagController.clear();
      }
    }
    void removeTag(String tag) {
      taggedPeople.remove(tag);

  // Get live event under create post
  var isCreatingPost = false.obs;

  }

  // ================Live comment
  Rx<TextEditingController> commentController = TextEditingController().obs;
  RxBool isPostingComment = false.obs;

  Future<void> liveComment({required String eventId}) async {
    final commentText = commentController.value.text.trim();
    if (commentText.isEmpty) return;
    isPostingComment.value = true;
    update();

    try {
      Map<String, dynamic> body = {
        "comments": commentText,
        "eventId": eventId,
      };

      final response = await ApiClient.postData(
        ApiUrl.postLiveComment,
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

         await getLiveComment(); // <-- if you have a method to refresh comments
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

  void clearCreatePostFields() {
    commentController.value.clear();
  }
  // ================ Get Live comment
  var comments = <LiveEvent>[].obs;
  var isCommentLoading = true.obs;
  var isMoreCommentLoading = false.obs;

  Future<void> getLiveComment() async {
    try {
      String eventId = await SharePrefsHelper.getString('selectedEventId');
      final response = await ApiClient.getData(ApiUrl.getLiveComment(eventId: eventId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = LiveEventResponse.fromJson(response.body);
        final newComments = model.data?.liveEvent ?? [];

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

  // ============= Get Under live events Post ===========
  var posts = <EventPost>[].obs;
  var isLoadingPosts = true.obs;
  var isMoreLoadingPosts = false.obs;
  var totalUnderLivePost = 0.obs;
  int currentPageUnderLivePost = 1;
  int totalPagesUnderLivePost = 1;

  String getUserName(String fullName) {
    if (fullName.isEmpty) return "";
    String lowerName = fullName.toLowerCase();
    return lowerName.split(" ").first;
  }


  Future<void> getAllPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPageUnderLivePost = 1;
      posts.clear();
      setRequestStatus(Status.loading);
    } else {
      if (currentPageUnderLivePost > totalPagesUnderLivePost) return;

      if (currentPageUnderLivePost == 1) {
        isLoadingPosts.value = true;
        setRequestStatus(Status.loading);
      }
      else {
        isMoreLoadingPosts.value = true;
      }
    }

    try {
      String eventId = await SharePrefsHelper.getString('selectedEventId');
      String pageName = await SharePrefsHelper.getString('pageName');

      final response = await ApiClient.getData(ApiUrl.liveEventGetPost(eventId: eventId, page: currentPageUnderLivePost));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = EventPostResponse.fromJson(response.body);

        currentPageUnderLivePost = model.meta?.page ?? 1;
        totalPagesUnderLivePost = model.meta?.totalPage ?? 1;
        totalUnderLivePost.value = model.meta?.total ?? 0;

        final newPosts = model.allEventPost ?? [];

        if (isRefresh || currentPageUnderLivePost == 1) {
          posts.assignAll(newPosts);
        } else {
          posts.addAll(newPosts);
        }


        setRequestStatus(Status.completed);
      } else {
    setRequestStatus(Status.error);
    Get.snackbar("Error", "Failed to load posts.");
    }
    } catch (e, stack) {
    setRequestStatus(Status.error);
    debugPrint(" Error fetching posts: $e");
    debugPrint(stack.toString());
    } finally {
    isMoreLoadingPosts.value = false;
    isLoadingPosts.value = false;
    }
  }

  //React function
  Future<void> toggleReact(String postId) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiUrl.baseUrl}${ApiUrl.reactPost}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${ApiClient.bearerToken}",
        },
        body: jsonEncode({"eventpostId": postId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          await getAllPosts(isRefresh: false);
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

  //follow function
  Future<void> toggleFollow(String userId) async {
    try {
      Map<String, dynamic> body = {
        "eventpostId": userId,
      };
      final  response = await ApiClient.postData(ApiUrl.addFollowLiveDetailsPage, jsonEncode(body),);

      final jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonEncode(response.body);

        showCustomSnackBar(
            jsonResponse['message']?.toString() ?? "Followed successfully!",
            isError: false
        );
        await getAllPosts(isRefresh: false);
      }
      else {
        Get.snackbar("Error", "Failed to Follow");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

  }
  // ============= Create Under live events Post ===========
  var isCreatingPost = false.obs;
  final captionController = TextEditingController();
  final tagController = TextEditingController();
  final locationNameController = TextEditingController();

  // Main method to create the post
  Future<void> createPost() async {
    try {
      if (selectedImage.value == null) {
        showCustomSnackBar("Please upload a photo or video");
        return;
      }

      if (captionController.text.isEmpty) {
        showCustomSnackBar("Please write a caption");
        return;
      }
      isCreatingPost.value = true;

      String eventId = await SharePrefsHelper.getString('selectedEventId');

      Map<String, dynamic> body = {
         "eventId": eventId,
        "caption": captionController.text,
        "content": locationNameController.text,
        "tag_people": taggedPeople.toList(),
      };

      dynamic response;
      if (selectedImage.value != null) {
        response = await ApiClient.postMultipartData(ApiUrl.liveEventCreatePost,
          {
            "data": jsonEncode(body),
          },
          multipartBody: [
            MultipartBody("file", selectedImage.value!),
          ],
        );
      }
      else {
        response = await ApiClient.postData(ApiUrl.liveEventCreatePost, jsonEncode(body),);
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
        //Get.offAllNamed(AppRoutes.socialScreen);
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
  void resetCreatePostFields() {
    selectedImage.value = null;
    captionController.clear();
    locationNameController.clear();
    tagController.clear();
    taggedPeople.clear();
  }

  // Get upcoming and past events
  Future<void> fetchUpcomingEvents() async {
    if (currentPage > totalPages) return;

    if (currentPage == 1) {
      isLoading.value = true;
      setUpcomingRequestStatus(Status.loading);
    } else {
      isMoreLoading.value = true;
    }

    try {
      //DateTime.now().toIso8601String().split('T')[0]
      final response = await ApiClient.getData(ApiUrl.dmUpcomingEvent(page: currentPage ),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];

        // Meta
        int totalUpcoming = data['meta']['totalUpcoming'];
        int totalPast = data['meta']['totalPast'] ;
        int limit = data['meta']['limit'] ;

        int total = totalUpcoming + totalPast;
        totalEvents.value = total;
        totalPages = (total / limit).ceil();
        // Parse events
        var myUpcomingEventList = data['events'] as List;
        var newUpcomingEvents = myUpcomingEventList.map((e) => Event.fromJson(e)).toList();

        if (currentPage == 1) upcomingEvents.clear();
        upcomingEvents.addAll(newUpcomingEvents);

        currentPage++;
        setUpcomingRequestStatus(Status.completed);
      } else {
        setUpcomingRequestStatus(Status.error);
      }
    } catch (e) {
      print("Error fetching live events: $e");
      setRequestStatus(Status.error);
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  // ==========Payment method ======
  RxBool isPayment = false.obs;

  Future<void> paymentMethod({required String selectedMethod,required int totalPrise,required int ticketCount}) async {
    try {
      isPayment.value = true;
      Map<String, dynamic> body = {
        "amount": totalPrise,
        "currency": "USD",
        "itemName": "Ticket Price",
        "itemDescription": "Confirm Your Ticket Price"
      };

      debugPrint("Api Body: $body");
      final response = await ApiClient.postData(ApiUrl.paymentMethod, jsonEncode(body));
      final jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      debugPrint("Api jsonResponse: $jsonResponse");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final approvalUrl = jsonResponse['data']?['approvalUrl'];

        if (approvalUrl != null && approvalUrl.toString().isNotEmpty) {
          await Get.to(() => PaypalPaymentPage(approvalUrl: approvalUrl));
        } else {
          showCustomSnackBar("Approval URL not found!", isError: true);
        }
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Payment failed!",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar("Error: $e", isError: true);
      debugPrint("Payment error: $e");
    } finally {
      isPayment.value = false;
      update();
    }
  }


  ///map controller
  final loc.Location locationController = loc.Location();
  static const LatLng nearByLocation = LatLng(23.7470, 90.4266);
  static const LatLng far = LatLng(23.8041, 90.3666);

  var currentPosition = Rxn<LatLng>();
  var currentAddress = "Loading...".obs;

  GoogleMapController? mapController;
  BitmapDescriptor? currentLocationIcon;
  BitmapDescriptor? farLocationIcon;
  BitmapDescriptor? nearByLocationIcon;

  Future<void> initializeCustomMarkers() async {
    currentLocationIcon = await CustomMarkers.createCurrentLocationMarker();
    farLocationIcon = await CustomMarkers.createFromIconData(
      Icons.location_pin,
      color: Colors.grey,
      size: 80,
    );
    nearByLocationIcon = await CustomMarkers.createFromIconData(
      Icons.location_pin,
      color: AppColors.lightGreen,
      size: 80,
    );
    update();
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted =
        await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    locationController.onLocationChanged
        .listen((loc.LocationData currentLocation) async {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        currentPosition.value =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);

        List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );

        if (placeMarks.isNotEmpty) {
          Placemark place = placeMarks.first;
          currentAddress.value = "${place.locality}, ${place.country}";
        }

        mapController?.animateCamera(
          CameraUpdate.newLatLng(currentPosition.value!),
        );
      }
    });
  }



}
