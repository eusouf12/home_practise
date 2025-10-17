import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CreateEventModel {
  CreateEventModel({
    this.eventTitle,
    this.id,
    this.description,
    this.date,
    this.photo,
    this.startingTime,
    this.endingTime,
    List<VenueFacility>? venueFacilities,
    this.eventCategory,
    this.eventFeatures,
    this.audienceSettings,
  }) :venueFacilities= venueFacilities ?? [];

  String? id;
  String? eventTitle;
  String? description;
  String? photo;
  DateTime? date;
  String? startingTime;
  String? endingTime;
  List<VenueFacility> venueFacilities;
  String? eventCategory;
  String? eventFeatures;
  AudienceSettings? audienceSettings;

  factory CreateEventModel.fromJson(Map<String, dynamic> json){
    DateTime? parsedDate;
    if (json["date"] != null && json["date"].toString().isNotEmpty) {
      try {
        parsedDate = DateFormat('yyyy-MM-dd').parse(json["date"]);

      } catch (e) {
        parsedDate = null;
        debugPrint("Date parsing error: $e");
      }
    }

    return CreateEventModel(
      id: json["_id"],
      eventTitle: json["event_title"],
      description: json["description"],
      date: parsedDate,
      photo: json["photo"],
      startingTime: json["starting_time"],
      endingTime: json["ending_time"],
      venueFacilities: json["venue_facilities"] == null ? [] : List<VenueFacility>.from(
          json["venue_facilities"]!.map((x) => VenueFacility.fromJson(x))),
      eventCategory: json["event_category"],
      eventFeatures: json["event_features"],
      audienceSettings: json["audience_settings"] == null
          ? null
          : AudienceSettings.fromJson(json["audience_settings"]),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "event_title": eventTitle,
      "description": description,
      "photo": photo,
      "date": date?.toIso8601String(),
      "starting_time": startingTime,
      "ending_time": endingTime,
      "venue_facilities": venueFacilities.map((x) => x.toJson()).toList(),
      "event_category": eventCategory,
      "event_features": eventFeatures,
      "audience_settings": audienceSettings?.toJson(),
    };
  }

// Optional: copyWith for convenience
  CreateEventModel copyWith({
    String? eventTitle,
    String? description,
    DateTime? date,
    String? photo,
    String? startingTime,
    String? endingTime,
    List<VenueFacility>? venueFacilities,
    String? eventCategory,
    String? eventFeatures,
    AudienceSettings? audienceSettings,
  }) {
    return CreateEventModel(
      eventTitle: eventTitle ?? this.eventTitle,
      description: description ?? this.description,
      date: date ?? this.date,
      photo: photo ?? this.photo,
      startingTime: startingTime ?? this.startingTime,
      endingTime: endingTime ?? this.endingTime,
      venueFacilities: venueFacilities ?? this.venueFacilities,
      eventCategory: eventCategory ?? this.eventCategory,
      eventFeatures: eventFeatures ?? this.eventFeatures,
      audienceSettings: audienceSettings ?? this.audienceSettings,
    );
  }
}

class AudienceSettings {
  AudienceSettings({
     this.age,
     this.maxCapacity,
     this.visibility,
     this.socialMedia,
     this.notification,
     this.pointSystem,
     this.ticketPrice,
     this.eventLocation,
  });

  String? age;
  num? maxCapacity;
  String? visibility;
  SocialMedia? socialMedia;
  Notification? notification;
  PointSystem? pointSystem;
  String? ticketPrice;
  EventLocation? eventLocation;

  factory AudienceSettings.fromJson(Map<String, dynamic> json){
    return AudienceSettings(
      age: json["age"]??"",
      maxCapacity: json["max_capacity"],
      visibility: json["visibility"],
      socialMedia: json["social_media"] == null ? null : SocialMedia.fromJson(json["social_media"]),
      notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
      pointSystem: json["point_system"] == null ? null : PointSystem.fromJson(json["point_system"]),
      ticketPrice: json["ticket_price"],
      eventLocation: json["event_location"] == null ? null : EventLocation.fromJson(json["event_location"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "age": age,
      "max_capacity": maxCapacity,
      "visibility": visibility,
      "social_media": socialMedia?.toJson(),
      "notification": notification?.toJson(),
      "point_system": pointSystem?.toJson(),
      "ticket_price": ticketPrice,
      "event_location": eventLocation?.toJson(),
    };
  }
}

class EventLocation {
  EventLocation({
     this.lat,
     this.lon,
  });

   String? lat;
   String? lon;

  factory EventLocation.fromJson(Map<String, dynamic> json){
    return EventLocation(
      lat: json["lat"],
      lon: json["lon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lon": lon,
    };
  }
}

class Notification {
  Notification({
     this.livechat,
     this.pushNotifications,
     this.eventCountdown,
  });

   bool? livechat;
   bool? pushNotifications;
   bool? eventCountdown;

  factory Notification.fromJson(Map<String, dynamic> json){
    return Notification(
      livechat: json["livechat"],
      pushNotifications: json["push_notifications"],
      eventCountdown: json["event_countdown"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "livechat": livechat,
      "push_notifications": pushNotifications,
      "event_countdown": eventCountdown,
    };
  }
}

class PointSystem {
  PointSystem({
     this.people,
     this.point,
  });

  final num? people;
  final num? point;

  factory PointSystem.fromJson(Map<String, dynamic> json){
    return PointSystem(
      people: json["people"],
      point: json["point"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "people": people,
      "point": point,
    };
  }
}

class SocialMedia {
  SocialMedia({
     this.content,
     this.gallery,
     this.sharing,
     this.streaming,
  });

   bool? content;
   bool? gallery;
   bool? sharing;
   bool? streaming;

  factory SocialMedia.fromJson(Map<String, dynamic> json){
    return SocialMedia(
      content: json["content"],
      gallery: json["gallery"],
      sharing: json["sharing"],
      streaming: json["streaming"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "gallery": gallery,
      "sharing": sharing,
      "streaming": streaming,
    };
  }
}

class VenueFacility {
  VenueFacility({
     this.type,
     this.available,
     this.description,
  });


  String? type;
  bool? available;
  String? description;
  factory VenueFacility.fromJson(Map<String, dynamic> json){
    return VenueFacility(
      type: json["type"],
      available: json["available"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "available": available,
      "description": description,
    };
  }
}


//  Get ChatroomModel host
class GetChatroomModel {
  final ChatroomData? data;

  GetChatroomModel({required this.data});

  factory GetChatroomModel.fromJson(Map<String, dynamic> json) {
    return GetChatroomModel(
      data: json["data"] == null ? null : ChatroomData.fromJson(json["data"]),
    );
  }
}

class ChatroomData {
  final Meta? meta;
  final List<AllEventChatroom> allEventChatroom;

  ChatroomData({required this.meta, required this.allEventChatroom});

  factory ChatroomData.fromJson(Map<String, dynamic> json) {
    return ChatroomData(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      allEventChatroom: json["all_event_chatroom"] == null
          ? []
          : List<AllEventChatroom>.from(
        json["all_event_chatroom"].map((x) => AllEventChatroom.fromJson(x)),
      ),
    );
  }
}

class AllEventChatroom {
  final String? id;
  final EventId? eventId;
  final String? hostId;
  final String? chatRoomName;
  final num? totalMember;

  AllEventChatroom({
    required this.id,
    required this.eventId,
    required this.hostId,
     this.chatRoomName,
     this.totalMember,
  });

  factory AllEventChatroom.fromJson(Map<String, dynamic> json) {
    return AllEventChatroom(
      id: json["_id"],
      eventId: json["eventId"] == null ? null : EventId.fromJson(json["eventId"]),
      hostId: json["hostId"],
      chatRoomName: json["chatRoomName"],
      totalMember: json["totalMember"],
    );
  }
}

class EventId {
  final String? id;
  final String? photo;

  EventId({required this.id, required this.photo});

  factory EventId.fromJson(Map<String, dynamic> json) {
    return EventId(
      id: json["_id"],
      photo: json["photo"],
    );
  }
}

class Meta {
  final num? page;
  final num? limit;
  final num? total;
  final num? totalPage;

  Meta({required this.page, required this.limit, required this.total, required this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }
}


//  Get GroupModel host


class GroupModel {
  final String id;
  final EventId? eventId;
  final String hostId;
  final String groupName;
  final int totalMember;

  GroupModel({
    required this.id,
    required this.eventId,
    required this.hostId,
    required this.groupName,
    required this.totalMember,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['_id'] ?? '',
      eventId: json['eventId'] != null
          ? EventId.fromJson(json['eventId'])
          : null,
      hostId: json['hostId'] ?? '',
      groupName: json['groupName'] ?? '',
      totalMember: json['totalMember'] ?? 0,
    );
  }
}

class GroupEventId {
  final String id;
  final String photo;

  GroupEventId({
    required this.id,
    required this.photo,
  });

  factory GroupEventId.fromJson(Map<String, dynamic> json) {
    return GroupEventId(
      id: json['_id'] ?? '',
      photo: json['photo'] ?? '',
    );
  }
}

//change password model
class ChangePassword {
  ChangePassword({
    required this.newPassword,
    required this.oldPassword,
  });

  final String? newPassword;
  final String? oldPassword;

  factory ChangePassword.fromJson(Map<String, dynamic> json){
    return ChangePassword(
      newPassword: json["newpassword"],
      oldPassword: json["oldpassword"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'newpassword': newPassword,
      'oldpassword': oldPassword,
    };
  }

}



// =================== live event detail post

class EventPostResponse {
  final MetaData? meta;
  final List<EventPost>? allEventPost;
  EventPostResponse({this.meta, this.allEventPost});

  factory EventPostResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return EventPostResponse(
      meta: data['meta'] != null ? MetaData.fromJson(data['meta']) : null,
      allEventPost: data['all_event_post'] != null
          ? List<EventPost>.from(
          data['all_event_post'].map((x) => EventPost.fromJson(x)))
          : [],
    );
  }
}
class MetaData {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  MetaData({this.page, this.limit, this.total, this.totalPage});

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    page: (json['page'] ?? 1).toInt(),
    limit: (json['limit'] ?? 10).toInt(),
    total: (json['total'] ?? 0).toInt(),
    totalPage: (json['totalPage'] ?? 1).toInt(),
  );
}
class EventPost {
  final String? id;
  final EventData? eventId;
  final UserData? userId;
  final String? content;
  final String? caption;
  final String? comments;
  final int? react;
  final int? comment;
  final int? share;
  final int? followup;
  final DateTime? createdAt;

  EventPost( {this.id, this.eventId,this.comments,  this.userId, this.content, this.caption,this.react, this.comment, this.share, this.followup, this.createdAt,});

  factory EventPost.fromJson(Map<String, dynamic> json) => EventPost(
    id: json['_id'],
    eventId: json['eventId'] != null ? EventData.fromJson(json['eventId']) : null,
    userId: json['userId'] != null ? UserData.fromJson(json['userId']) : null,
    content: json['content'],
    comments: json['comments'],
    caption: json['caption'],
    react: json['react'] ?? 0,
    comment: json['comment'] ?? 0,
    share: json['share'] ?? 0,
    followup: json['followup'] ?? 0,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'])
        : null,
  );
}
class EventData {
  final String? id;
  final String? eventTitle;
  final AudienceSettingsLive? audienceSettings;

  EventData({this.id, this.eventTitle, this.audienceSettings});

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
    id: json['_id'],
    eventTitle: json['event_title'],
    audienceSettings: json['audience_settings'] != null
        ? AudienceSettingsLive.fromJson(json['audience_settings'])
        : null,
  );
}
class AudienceSettingsLive {
  final EventLocationLive? eventLocation;

  AudienceSettingsLive({this.eventLocation});

  factory AudienceSettingsLive.fromJson(Map<String, dynamic> json) =>
      AudienceSettingsLive(
        eventLocation: json['event_location'] != null
            ? EventLocationLive.fromJson(json['event_location'])
            : null,
      );
}
class EventLocationLive {
  final String? lat;
  final String? lon;
  final String? id;

  EventLocationLive({this.lat, this.lon, this.id});

  factory EventLocationLive.fromJson(Map<String, dynamic> json) =>
      EventLocationLive(
        lat: json['lat'],
        lon: json['lon'],
        id: json['_id'],
      );
}
class UserData {
  final String? id;
  final String? name;
  final String? photo;
  final DateTime? createdAt;

  UserData({this.id, this.name, this.photo, this.createdAt});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['_id'],
    name: json['name'],
    photo: json['photo'],
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'])
        : null,
  );
}

// =================== live event detail post end


//==============  live post comment

class LiveEventResponse {
  final bool? success;
  final String? message;
  final LiveEventData? data;

  LiveEventResponse({this.success, this.message, this.data});

  factory LiveEventResponse.fromJson(Map<String, dynamic> json) =>
      LiveEventResponse(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? LiveEventData.fromJson(json['data']) : null,
      );
}

class LiveEventData {
  final MetaData? meta;
  final List<LiveEvent>? liveEvent;

  LiveEventData({this.meta, this.liveEvent});

  factory LiveEventData.fromJson(Map<String, dynamic> json) => LiveEventData(
    meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    liveEvent: json['liveEvent'] != null
        ? List<LiveEvent>.from(
        json['liveEvent'].map((x) => LiveEvent.fromJson(x)))
        : [],
  );
}

class MetaDataComment {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  MetaDataComment({this.page, this.limit, this.total, this.totalPage});

  factory MetaDataComment.fromJson(Map<String, dynamic> json) => MetaDataComment(
    page: (json['page'] ?? 1).toInt(),
    limit: (json['limit'] ?? 10).toInt(),
    total: (json['total'] ?? 0).toInt(),
    totalPage: (json['totalPage'] ?? 1).toInt(),
  );
}

class LiveEvent {
  final String? id;
  final LiveUser? user;
  final String? comments;
  final DateTime? createdAt;

  LiveEvent({this.id, this.user, this.comments, this.createdAt});

  factory LiveEvent.fromJson(Map<String, dynamic> json) => LiveEvent(
    id: json['_id'],
    user: json['userId'] != null ? LiveUser.fromJson(json['userId']) : null,
    // backend sometimes sends "comments" and sometimes "comment"
    comments: json['comments'] ?? json['comment'] ?? '',
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'])
        : null,
  );
}

class LiveUser {
  final String? id;
  final String? name;
  final String? photo;

  LiveUser({this.id, this.name, this.photo});

  factory LiveUser.fromJson(Map<String, dynamic> json) => LiveUser(
    id: json['_id'],
    name: json['name'],
    photo: json['photo'],
  );
}



