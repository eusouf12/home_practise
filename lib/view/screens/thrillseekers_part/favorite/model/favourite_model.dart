class MyFavoriteEventModel {
  final bool? success;
  final String? message;
  final FavoriteEventData? data;

  MyFavoriteEventModel({
    this.success,
    this.message,
    this.data,
  });

  factory MyFavoriteEventModel.fromJson(Map<String, dynamic> json) {
    return MyFavoriteEventModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? FavoriteEventData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class FavoriteEventData {
  final Meta? meta;
  final List<MyFavoriteEvent>? myFavoriteEvent;

  FavoriteEventData({
    this.meta,
    this.myFavoriteEvent,
  });

  factory FavoriteEventData.fromJson(Map<String, dynamic> json) {
    return FavoriteEventData(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      myFavoriteEvent: json['my_favorite_event'] != null
          ? List<MyFavoriteEvent>.from(
          json['my_favorite_event'].map((x) => MyFavoriteEvent.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'my_favorite_event':
    myFavoriteEvent?.map((x) => x.toJson()).toList(),
  };
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPage': totalPage,
  };
}

class MyFavoriteEvent {
  final String? id;
  final String? name;
  final String? address;
  final double? rating;
  final Location? location;
  final String? placeId;
  final bool? openNow;
  final String? image;

  MyFavoriteEvent({
    this.id,
    this.name,
    this.address,
    this.rating,
    this.location,
    this.placeId,
    this.openNow,
    this.image,
  });

  factory MyFavoriteEvent.fromJson(Map<String, dynamic> json) {
    return MyFavoriteEvent(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      rating: (json['rating'] ?? 0).toDouble(),
      location:
      json['location'] != null ? Location.fromJson(json['location']) : null,
      placeId: json['placeId'],
      openNow: json['openNow'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'address': address,
    'rating': rating,
    'location': location?.toJson(),
    'placeId': placeId,
    'openNow': openNow,
    'image': image,
  };
}

class Location {
  final double? lat;
  final double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}



