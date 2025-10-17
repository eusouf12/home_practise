import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../event/model/update_model.dart';
import '../model/creat_event_model.dart';

class HomeController extends GetxController {
  // Date
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);

  // Format Date
  String get formattedDate {
    if (selectedDate.value != null) {
      return DateFormat('dd-MM-yyyy').format(selectedDate.value!);
    }
    return '';
  }
  String get formattedStartTime {
    if (startTime.value != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day,
          startTime.value!.hour, startTime.value!.minute);
      return DateFormat('hh:mm a').format(dt);
    }
    return '';
  }
  String get formattedEndTime {
    if (endTime.value != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day,
          endTime.value!.hour, endTime.value!.minute);
      return DateFormat('hh:mm a').format(dt);
    }
    return '';
  }

  // Pick Date
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  // Pick Start Time
  Future<void> pickStartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: startTime.value ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), // force 12h format
            child: child!,
          );
        },
    );
    if (picked != null) {
      startTime.value = picked;
    }
  }

  // Pick End Time
  Future<void> pickEndTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: endTime.value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      endTime.value = picked;
    }
  }

  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  ///Event Filter
  String eventFilter = 'Parties';
  final List<String> eventOptions = [
    'Parties',
    'Foot Festivals',
    'Neighborhood Events',
    'Family-Friendly',
    'Sports',
    'Concerts',
    'Custom'
  ];
  void updateEventFilter(String value) {
    eventFilter = value;
  }

  ///Event Feature
  String eventFeatures = 'Outdoor';
  final List<String> featuresOptions = ['Outdoor', 'Indoor', 'Wheelchair Accessible', 'Pet Friendly', 'ASL Interpreter'];
  void updateEventFeature(String value) {
    eventFeatures = value;
  }

/// public & Private
  String eventGroup = 'Public';
  RxBool isPublic = true.obs;

  void updateVisibility(bool value) {
    isPublic.value = value;
    eventGroup = value ? "Public" : "Private";
  }

  /// Reactive map for social media options
  final Map<String, String> optionSocialMedia = {
    "content": "Allow photo/video uploads",
    "gallery": "Enable event gallery",
    "sharing": "Enable event sharing",
    "streaming": "Live streaming",
  };

  RxMap<String, bool> socialMedia = {
    "content": false,
    "gallery": false,
    "sharing": false,
    "streaming": false,
  }.obs;

  void toggleOption(String key, bool value) {
    socialMedia[key] = value;
  }
  /// Reactive map for notification options
  final Map<String, String> optionNotification = {
    "livechat": "Enable live chat or Q&A",
    "push_notifications": "Enable push notifications for last-minute ",
    "event_countdown": "Set live event countdown"
  };
  RxMap<String, bool> notification = {
    "livechat": false,
    "push_notifications": false,
    "event_countdown": false
  }.obs;

  void toggleOptionNotification(String key, bool value) {
    notification[key] = value;
  }

  bool get isSocialMediaValid =>
      socialMedia.values.any((value) => value == true);

  bool get isNotificationValid =>
      notification.values.any((value) => value == true);

  /// Point system
  RxBool pointSystemEnabled = true.obs;
  RxInt peopleCount = 1.obs;
  RxDouble pointValue = 10.0.obs;

  Map<String, dynamic> get pointSystem => {
    "people": peopleCount.value,
    "point": pointValue.value,
  };
  /// Ticket price
  RxString ticketType = "Free".obs;
  String get ticketPrice => ticketType.value == "Free" ? "free" : "paid";

  ///Google map apply for location
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  Future<void> getCoordinates(String place) async {
    const apiKey = "AIzaSyAFDdENuKmGpQiN7NLZGp5Prw1VQ8hEcms";
    debugPrint("Map Place =====: ${place}");

    final autoUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&types=geocode&components=country:bd&key=$apiKey";

    final autoResponse = await http.get(Uri.parse(autoUrl));

    final autoData = jsonDecode(autoResponse.body);

    if (autoData["status"] == "OK") {
      final placeId = autoData["predictions"][0]["place_id"];

      final detailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";

      final detailsResponse = await http.get(Uri.parse(detailsUrl));
      final detailsData = jsonDecode(detailsResponse.body);

      if (detailsData["status"] == "OK") {
        final location = detailsData["result"]["geometry"]["location"];

        latitude.value = location["lat"].toString();
        longitude.value = location["lng"].toString();

        debugPrint("Latitude After: ${latitude.value}");
        debugPrint("Longitude After: ${longitude.value}");
      }
    }
    else {
      latitude.value = "23.8041";
      longitude.value = "90.4152";
      debugPrint("Else Latitude After: ${latitude.value}");
      debugPrint(" Else Longitude After: ${longitude.value}");
    }
  }

  // Future<void> getCoordinates(String place) async {
  //
  //   const apiKey = "AIzaSyAFDdENuKmGpQiN7NLZGp5Prw1VQ8hEcms";
  //
  //   // Autocomplete API
  //   final autoUri = Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json',
  //     {
  //       'input': place,  'types': 'geocode', 'components': 'country:bd', 'language': 'en',
  //        'key': apiKey,
  //     },
  //   );
  //
  //   final autoResponse = await http.get(autoUri);
  //   final autoData = jsonDecode(autoResponse.body);
  //
  //   if (autoData['status'] == 'OK' && autoData['predictions'].isNotEmpty) {
  //     final placeId = autoData['predictions'][0]['place_id'];
  //     final detailsUri = Uri.https('maps.googleapis.com', '/maps/api/place/details/json',
  //       {
  //         'place_id': placeId,'fields': 'geometry,formatted_address','language': 'en',
  //         'key': apiKey,
  //       },
  //
  //     );
  //
  //     final detailsResponse = await http.get(detailsUri);
  //     final detailsData = jsonDecode(detailsResponse.body);
  //     if (detailsData['status'] == 'OK') {
  //       final location = detailsData['result']['geometry']['location'];
  //       latitude.value = location['lat'].toString();
  //       longitude.value = location['lng'].toString();
  //       placeName.value = detailsData['result']['formatted_address'];
  //     }
  //
  //   } else {
  //     latitude.value = "";
  //     longitude.value = "";
  //     placeName.value = "";
  //   }
  //
  // }

  Future<void> getPlaceNameFromCoordinates(String lat, String lon) async {
    if (lat.isEmpty || lon.isEmpty) {
      placeName.value = ""; return;

    }

    const apiKey = "AIzaSyAFDdENuKmGpQiN7NLZGp5Prw1VQ8hEcms";
    final reverseUri = Uri.https(

      'maps.googleapis.com', '/maps/api/geocode/json',
      {
        'latlng': '$lat,$lon',

        'language': 'en',

        'result_type': 'street_address|locality|sublocality',

        'key': apiKey,

      },

    );

    final response = await http.get(reverseUri);

    final data = jsonDecode(response.body);

    if (data['status'] == 'OK' && data['results'].isNotEmpty) {

      placeName.value = data['results'][0]['formatted_address'];

    } else {

      placeName.value = "Unknown Location";

    }

  }


  // Future<void> getPlaceNameFromCoordinates(String lat, String lon) async {
  //   if (lat.isEmpty || lon.isEmpty) {
  //     placeName.value = "";
  //     return;
  //   }
  //   const apiKey = "AIzaSyAFDdENuKmGpQiN7NLZGp5Prw1VQ8hEcms";
  //
  //   final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$apiKey";
  //
  //   final response = await http.get(Uri.parse(url));
  //   final data = jsonDecode(response.body);
  //
  //   if (data["status"] == "OK" && data["results"].isNotEmpty) {
  //     placeName.value = data["results"][0]["formatted_address"];
  //   } else {
  //     placeName.value = "Unknown Location";
  //   }
  // }


  // reverse place name



  /// Create Event
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<TextEditingController> washroomController = TextEditingController().obs;
  Rx<TextEditingController> handWashController = TextEditingController().obs;
  Rx<TextEditingController> smokingZoneController = TextEditingController().obs;
  Rx<TextEditingController> foodCourtController = TextEditingController().obs;
  Rx<TextEditingController> restAreaController = TextEditingController().obs;
  Rx<TextEditingController> maxCapacityController = TextEditingController().obs;
  Rx<TextEditingController> ageController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  RxBool createEventLoading = false.obs;
  Rx<CreateEventModel> createEventModel = CreateEventModel(
    eventTitle: '',
    description: '',
    date: DateTime.now(),
    startingTime: '',
    endingTime: '',
    venueFacilities: [],
    eventCategory: '',
    eventFeatures: '',
    audienceSettings: null,
  ).obs;

  Future<void> createEvent() async {
    createEventLoading.value = true;
    update();
    try {
      createEventModel.value = createEventModel.value.copyWith(
        venueFacilities: [
          VenueFacility(
            type: "washroom",
            available: washroomController.value.text.isNotEmpty,
            description: washroomController.value.text.trim(),
          ),
          VenueFacility(
            type: "handwashstation",
            available: handWashController.value.text.isNotEmpty,
            description: handWashController.value.text.trim(),
          ),
          VenueFacility(
            type: "smokingzone",
            available: smokingZoneController.value.text.isNotEmpty,
            description: smokingZoneController.value.text.trim(),
          ),
          VenueFacility(
            type: "foorcount",
            available: foodCourtController.value.text.isNotEmpty,
            description: foodCourtController.value.text.trim(),
          ),
          VenueFacility(
            type: "restarea",
            available: restAreaController.value.text.isNotEmpty,
            description: restAreaController.value.text.trim(),
          ),
        ],
      );
      String? email;
      if (eventGroup == "Private") {
        email = emailController.value.text.trim();
        if (email.isEmpty || !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
          showCustomSnackBar("Please enter a valid email for private events", isError: true);
          createEventLoading.value = false;
          update();
          return;
        }
      }

      Map<String, dynamic> body = {
        "event_title": titleController.value.text.trim(),
        "description": descriptionController.value.text.trim(),
        "date": formattedDate,
        "starting_time": formattedStartTime,
        "ending_time": formattedEndTime,
        "event_category": eventFilter,
        "event_features": eventFeatures,
      };
      body["venue_facilities"] = createEventModel.value.venueFacilities.map((v) => v.toJson()).toList();
      body["audience_settings"] = {
        ...?createEventModel.value.audienceSettings?.toJson(),
        "event_location": {
          "lat": latitude.value,
          "lon": longitude.value,
        },
        "age": ageController.value.text.trim(),
        "max_capacity": int.tryParse(maxCapacityController.value.text.trim()),
        "visibility": eventGroup,
        if (eventGroup == "Private")
          "email": email,
        "social_media": socialMedia,
        "notification": notification,
        "point_system": pointSystem,
        "ticket_price": ticketPrice,
        if (ticketPrice == "paid")
          "price": int.tryParse(priceController.value.text.trim()),

      };
      debugPrint("Request body: ${jsonEncode(body)}");
      dynamic response;
      if (selectedImage.value!= null) {
        response = await ApiClient.postMultipartData(ApiUrl.createEvent,
          {
            "data": jsonEncode(body),
          },
          multipartBody: [
            MultipartBody("file", selectedImage.value!),
          ],
        );
      }
      else {
        response = await ApiClient.postData(ApiUrl.createEvent, jsonEncode(body),);
      }
      createEventLoading.value = false;
      update();

      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      debugPrint("Response: ${jsonEncode(jsonResponse)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Event created successfully!", isError: false,);
        _clearFormData();
        Get.offAllNamed(AppRoutes.homeScreen);
      }
      else {
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Create event failed", isError: true,);
      }
    } catch (e) {
      createEventLoading.value = false;
      update();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("Event create error: $e");
    }
  }

// Helper method to clear form data
  void _clearFormData() {
    titleController.value.clear();
    descriptionController.value.clear();

    createEventModel.value = CreateEventModel(
      eventTitle: '',
      description: '',
      date: DateTime.now(),
      startingTime: '',
      endingTime: '',
      venueFacilities: [],
      eventCategory: '',
      eventFeatures: '',
      audienceSettings: null,
    );

    selectedImage.value = null;
  }

//========== Update Event ==========
  RxBool updateEventLoading = false.obs;
  Rx<TextEditingController> updateTitleController = TextEditingController().obs;
  Rx<TextEditingController> updateDescriptionController = TextEditingController().obs;
  // Rx<TextEditingController> dateController = TextEditingController().obs;
  var eventImage = ''.obs;
  var placeName = ''.obs;

  Future<void> updateEvent(String eventId) async {
    updateEventLoading.value = true;
    update();

    try {
      final token = await SharePrefsHelper.getString(AppConstants.bearerToken);
      Map<String, dynamic> body = {
        "event_title": updateTitleController.value.text.trim(),
        "description": updateDescriptionController.value.text.trim(),
        "date": formattedDate,
        "starting_time": formattedStartTime,
        "ending_time": formattedEndTime,
      };
      body["audience_settings"] = {
        ...?createEventModel.value.audienceSettings?.toJson(),
        "event_location": {
          "lat": latitude.value,
          "lon": longitude.value,
        },
      };
      dynamic response;

      if (selectedImage.value != null) {
        response = await ApiClient.patchMultipartData(ApiUrl.updateEvent(eventId: eventId),
          {
            "data": jsonEncode(body),
          },
          multipartBody: [
            MultipartBody("file", selectedImage.value!),
          ],
        );
      } else {
        // JSON request
        response = await ApiClient.patchData(ApiUrl.updateEvent(eventId: eventId), jsonEncode(body),
          headers: {
            "Authorization": token,
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );
      }
      Map<String, dynamic> jsonResponse = {};
      if (response.body != null) {
        jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : response.body as Map<String, dynamic>;
      }

      updateEventLoading.value = false;
      update();

      // Map<String, dynamic> jsonResponse = response.body is String
      //     ? jsonDecode(response.body)
      //     : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Event updated successfully!",
          isError: false,
        );
         Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Update failed",
          isError: true,
        );
      }
    } catch (e) {
      updateEventLoading.value = false;
      update();
      showCustomSnackBar(
        "An error occurred. Please try again.",
        isError: true,
      );
      debugPrint("Event update error: $e");
    }
  }

  //  ------ Fetch event by ID-------
  RxBool getEventByIdLoading = false.obs;
  var specificEvent = <Event3>[].obs;

  Future<void> fetchEventById(String eventId) async {
    try {
      getEventByIdLoading.value = true;

      // API call
      final response = await ApiClient.getData(ApiUrl.getEventById(eventId: eventId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the event response
        final eventResponse = EventResponse3.fromJson(response.body);
        final eventData = eventResponse.data;

        // Save full event object
        specificEvent.clear();
        specificEvent.add(eventData);

        // Update UI fields
        updateTitleController.value.text = eventData.eventTitle ?? '';
        updateDescriptionController.value.text = eventData.description ?? '';

        // Date
        if (eventData.date != null && eventData.date!.isNotEmpty) {
          selectedDate.value = DateFormat('dd-MM-yyyy').parse(eventData.date!);
        }

        // Start Time
        if (eventData.startingTime != null && eventData.startingTime!.isNotEmpty) {
          final startDt = DateFormat('HH:mm').parse(eventData.startingTime!.trim());
          startTime.value = TimeOfDay(hour: startDt.hour, minute: startDt.minute);
        }

        // End Time
        if (eventData.endingTime != null && eventData.endingTime!.isNotEmpty) {
          final endDt = DateFormat('HH:mm').parse(eventData.endingTime!.trim());
          endTime.value = TimeOfDay(hour: endDt.hour, minute: endDt.minute);
        }

        // Event image
        eventImage.value = eventData.photo != null
            ? '${ApiUrl.baseUrl}/${eventData.photo}'
            : '';

        // Audience settings and location
        if (eventData.audienceSettings?.eventLocation != null) {
          latitude.value = eventData.audienceSettings!.eventLocation!.lat ?? '';
          longitude.value = eventData.audienceSettings!.eventLocation!.lon ?? '';

          if (latitude.value.isNotEmpty && longitude.value.isNotEmpty) {
            await getPlaceNameFromCoordinates(latitude.value, longitude.value);
            locationController.value.text = placeName.value;
          }
        }
      } else {
        setRequestStatus(Status.error);
        Get.snackbar("Error", "Failed to load event.");
      }
    } catch (e) {
      setRequestStatus(Status.error);
      debugPrint("Parsing error: $e");
    } finally {
      getEventByIdLoading.value = false;
    }
  }


//========== Get HostEvent controller ==========

  final rxRequestStatus = Status.loading.obs;
  void setRequestStatus(Status status) => rxRequestStatus.value = status;
  var events = <HostEventModel>[].obs;
  var totalEvents = 0.obs;
  var currentPage = 1;
  var totalPages = 1;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  Rx<HostEventModel> hostEventModel = HostEventModel(id: '', eventTitle: '', date: '', startingTime: '', endingTime: '', photo: '',).obs;
  Future<void> getAllHostEvent({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      events.clear();
    }
    if (currentPage > totalPages) return;
    if (currentPage == 1) {
      isLoading.value = true;
    } else {
      isMoreLoading.value = true;
    }
    try {
      var response = await ApiClient.getData(ApiUrl.allHostEvent(page: currentPage));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body['data'];
        // Parse meta
        var meta = data['meta'];
        totalPages = meta['totalPage'];
        totalEvents.value = meta['total'];

        // Parse events list
        var myEventList = data['myEvent'] as List;
        var newEvents = myEventList.map((e) => HostEventModel.fromJson(e)).toList();

        events.addAll(newEvents);
        currentPage++;
        setRequestStatus(Status.completed);
      } else {
        setRequestStatus(Status.error);
        Get.snackbar("Error", "Failed to load events.");
      }
    } catch (e) {
      setRequestStatus(Status.error);
      debugPrint("Parsing error: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

}

class HostEventModel {
   String id;
   String? eventTitle;
   String? date;
   String? startingTime;
   String? endingTime;
   String? photo;
   AudienceSettings? audienceSettings;

  HostEventModel({
    required this.id,
    this.eventTitle,
    this.date,
    this.startingTime,
    this.endingTime,
    this.photo,
  });

  factory HostEventModel.fromJson(Map<String, dynamic> json) {
    return HostEventModel(
      id: json['_id'] ?? json['id'] ?? '',
      eventTitle: json['event_title'],
      date: json['date'],
      startingTime: json['starting_time'],
      endingTime: json['ending_time'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'event_title': eventTitle,
      'date': date,
      'starting_time': startingTime,
      'ending_time': endingTime,
      'photo': photo,
    };
  }
}
