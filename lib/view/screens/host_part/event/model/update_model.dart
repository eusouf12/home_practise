class EventResponse3 {
  final bool success;
  final String message;
  final Event3 data;

  EventResponse3({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventResponse3.fromJson(Map<String, dynamic> json) {
    return EventResponse3(
      success: json['success'],
      message: json['message'],
      data: Event3.fromJson(json['data']),
    );
  }
}

class Event3 {
  final String id;
  final String? eventTitle;
  final String? description;
  final String? photo;
  final String? date;
  final String? startingTime;
  final String? endingTime;
  final List<VenueFacility3>? venueFacilities;
  final AudienceSettings3? audienceSettings;

  Event3({
    required this.id,
    this.eventTitle,
    this.description,
    this.photo,
    this.date,
    this.startingTime,
    this.endingTime,
    this.venueFacilities,
    this.audienceSettings,
  });

  factory Event3.fromJson(Map<String, dynamic> json) {
    return Event3(
      id: json['_id'],
      eventTitle: json['event_title'],
      description: json['description'],
      photo: json['photo'],
      date: json['date'],
      startingTime: json['starting_time'],
      endingTime: json['ending_time'],
      venueFacilities: json['venue_facilities'] != null
          ? (json['venue_facilities'] as List)
          .map((e) => VenueFacility3.fromJson(e))
          .toList()
          : null,
      audienceSettings: json['audience_settings'] != null
          ? AudienceSettings3.fromJson(json['audience_settings'])
          : null,
    );
  }
}

class VenueFacility3 {
  final String type;
  final bool available;
  final String? description;
  final String id;

  VenueFacility3({
    required this.type,
    required this.available,
    this.description,
    required this.id,
  });

  factory VenueFacility3.fromJson(Map<String, dynamic> json) {
    return VenueFacility3(
      type: json['type'],
      available: json['available'],
      description: json['description'],
      id: json['_id'],
    );
  }
}

class AudienceSettings3 {
  final String? age;
  final String? ticketPrice;
  final double? price;
  final EventLocation? eventLocation;

  AudienceSettings3({
    this.age,
    this.ticketPrice,
    this.price,
    this.eventLocation,
  });

  factory AudienceSettings3.fromJson(Map<String, dynamic> json) {
    return AudienceSettings3(
      age: json['age'],
      ticketPrice: json['ticket_price'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      eventLocation: json['event_location'] != null
          ? EventLocation.fromJson(json['event_location'])
          : null,
    );
  }
}

class EventLocation {
  final String? lat;
  final String? lon;
  final String id;

  EventLocation({
    this.lat,
    this.lon,
    required this.id,
  });

  factory EventLocation.fromJson(Map<String, dynamic> json) {
    return EventLocation(
      lat: json['lat'],
      lon: json['lon'],
      id: json['_id'],
    );
  }
}
