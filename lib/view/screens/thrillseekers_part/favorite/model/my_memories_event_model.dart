import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyMemoriesEventResponse {
  final bool success;
  final String message;
  final MyMemoriesData data;

  MyMemoriesEventResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MyMemoriesEventResponse.fromJson(Map<String, dynamic> json) {
    return MyMemoriesEventResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: MyMemoriesData.fromJson(json['data'] ?? {}),
    );
  }
}

class MyMemoriesData {
  final Meta meta;
  final List<MyMemoriesEvent> myMemoriesEvent;

  MyMemoriesData({
    required this.meta,
    required this.myMemoriesEvent,
  });

  factory MyMemoriesData.fromJson(Map<String, dynamic> json) {
    var list = json['my_memories_event'] as List? ?? [];
    return MyMemoriesData(
      meta: Meta.fromJson(json['meta'] ?? {}),
      myMemoriesEvent: list.map((e) => MyMemoriesEvent.fromJson(e)).toList(),
    );
  }
}

class Meta {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}

class MyMemoriesEvent {
  final String id;
  final String content;
  final String contentType;
  final String description;
  final int isFavorite;
  RxBool isLove;
  final String createdAt;

  MyMemoriesEvent({
    required this.id,
    required this.content,
    required this.contentType,
    required this.description,
    required this.isFavorite,
    required bool isLove,
    required this.createdAt,
  }) : isLove = isLove.obs;

  factory MyMemoriesEvent.fromJson(Map<String, dynamic> json) {
    return MyMemoriesEvent(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      contentType: json['contentType'] ?? '',
      description: json['description'] ?? '',
      isFavorite: json['isFavorite'] ?? 0,
      isLove: json['isLove'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }
}

