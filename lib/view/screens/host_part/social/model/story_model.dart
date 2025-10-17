class StoryModel {
  final List<FeedModel> feeds;

  StoryModel({required this.feeds});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    final feedsJson = json['feeds'] as List? ?? [];
    return StoryModel(
      feeds: feedsJson
          .map((e) => FeedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FeedModel {
  final String id;
  final String userId;
  final String? message;
  final String? content;
  final String createdAt;

  FeedModel({
    required this.id,
    required this.userId,
    this.message,
    this.content,
    required this.createdAt,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      message: json['message']?.toString(),
      content: json['content']?.toString(),
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
