  class FavoriteEventModel {
  final bool? success;
  final String? message;
  final EventData? data;

  FavoriteEventModel({
    this.success,
    this.message,
    this.data,
  });

  factory FavoriteEventModel.fromJson(Map<String, dynamic> json) {
    return FavoriteEventModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? EventData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class EventData {
  final String? id;
  final UserId? userId;
  final String? name;
  final String? address;
  final double? rating;
  final int? totalRatings;
  final Location? location;
  final String? placeId;
  final List<String>? types;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? isReact;

  EventData({
    this.id,
    this.userId,
    this.name,
    this.address,
    this.rating,
    this.totalRatings,
    this.location,
    this.placeId,
    this.types,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isReact,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      name: json['name'],
      address: json['address'],
      rating: (json['rating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      placeId: json['placeId'],
      types: json['types'] != null ? List<String>.from(json['types']) : [],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      isReact: json['isReact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(),
      'name': name,
      'address': address,
      'rating': rating,
      'totalRatings': totalRatings,
      'location': location?.toJson(),
      'placeId': placeId,
      'types': types,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'isReact': isReact,
    };
  }
}

class UserId {
  final String? id;
  final String? name;
  final String? photo;

  UserId({
    this.id,
    this.name,
    this.photo,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      name: json['name'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'photo': photo,
    };
  }
}

class Location {
  final double? lat;
  final double? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
