import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
class EventService extends GetxService {
  Future<EventData?> fetchEvents({required int page, required String searchTerm}) async {
    final String apiPath = '/api/v1/event/my_event_type_ways_filtering?page=$page&limit=10&searchTerm=$searchTerm';

    final Response response = await ApiClient.getData(apiPath);

    if (response.statusCode == 200 && response.body != null) {
      final EventResponse eventResponse = EventResponse.fromJson(response.body);
      return eventResponse.data;
    } else {
      throw Exception(response.statusText ?? 'Failed to load events.');
    }
  }
}


class EventController extends GetxController {
  final List<String> tabNames = ["all", "live", "upcoming", "past"];

  @override
  void onInit() {
    super.onInit();
    fetchInitialEvents(tabNames[currentIndex.value]);
  }
  void onTabSelected(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      fetchInitialEvents(tabNames[index]); // Load first page of selected tab
    }
  }



  final EventService _eventService = Get.find<EventService>();
  var currentIndex = 0.obs;
  var events = <Event>[].obs;
  var isLoading = true.obs;
  var isMoreLoading = false.obs;
  var totalEvents = 0.obs;
  int currentPage = 1;
  int totalPages = 1;
  //var totalAttendance = 0.obs;
  //var ratings = 0.0.obs;

  Future<void> fetchInitialEvents(String searchTerm) async {
    currentPage = 1;
    totalPages = 1;
    events.clear();
    await fetchEvents(searchTerm);
  }

  // Method to fetch data from the API based on the search term
  Future<void> fetchEvents(String searchTerm) async {
    if (currentPage > totalPages) return;

    if (currentPage == 1) {
      isLoading.value = true;
    } else {
      isMoreLoading.value = true;
    }
    try {
      final data = await _eventService.fetchEvents(page: currentPage, searchTerm: searchTerm);

      if (data != null) {
        if (data.myEvent.isNotEmpty) {
          events.addAll(data.myEvent);
        }

        // Update meta info even if list is empty
        totalEvents.value = data.meta.total;
        totalPages = data.meta.totalPage;
        currentPage++;
      }
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

}

///============= Event Model ==========
class EventResponse {
  final bool success;
  final String message;
  final EventData data;

  EventResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      success: json['success'],
      message: json['message'],
      data: EventData.fromJson(json['data']),
    );
  }
}

class EventData {
  final Meta meta;
  final List<Event> myEvent;

  EventData({required this.meta, required this.myEvent});

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      meta: Meta.fromJson(json['meta']),
      myEvent: (json['myEvent'] as List)
          .map((e) => Event.fromJson(e))
          .toList(),
    );
  }
}

class Meta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

class Event {
  final String id;
  final String? eventTitle;
  final String? date;
  final String? startingTime;
  final String? endingTime;
  final AudienceSettings? audienceSettings;
  final String? createdAt;
  final String? photo;
  final int? maxCapacity;
  final String? type;
  final int? price;
  final String? ticket_Price;

  Event({
    this.ticket_Price,
    required this.id,
    this.eventTitle,
    this.date,
    this.startingTime,
    this.endingTime,
    this.audienceSettings,
    this.createdAt,
    this.photo,
    this.maxCapacity,
    this.type,
    this.price,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'] ?? '',
      eventTitle: json['event_title'],
      date: json['date'],
      photo: json['photo'],
      startingTime: json['starting_time'],
      endingTime: json['ending_time'],
      audienceSettings: json['audience_settings'] != null
          ? AudienceSettings.fromJson(json['audience_settings'])
          : null,
      maxCapacity: json['max_capacity'] ?? json['audience_settings']?['max_capacity'],
      type: json['type'],
      price: json['price'],
      ticket_Price: json['ticket_price'],
      createdAt: json['createdAt'],
    );
  }
}

class AudienceSettings {
  final int? maxCapacity;

  AudienceSettings({this.maxCapacity});

  factory AudienceSettings.fromJson(Map<String, dynamic> json) {
    return AudienceSettings(
      maxCapacity: json['max_capacity'],
    );
  }
}

