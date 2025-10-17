import 'dart:convert';
import 'package:get/get.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));
class PostModel {
  final String id;
  final String? content;
  final String? caption;
  final int comment;
  final int share;
  final int followup;
  final DateTime createdAt;
  final UserModel user;
  final String feedType;
  late RxInt react;
  final  bool isReacted;

  PostModel({
    required this.id,
    this.content,
    required this.caption,
    required this.comment,
    required this.share,
    required this.followup,
    required this.createdAt,
    required this.user,
    required this.feedType,
    required int react,
    required this.isReacted,
  }){
    this.react = react.obs;

  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["_id"],
      content: json["content"],
      caption: json["caption"],
      react: json["react"] ?? 0,
      comment: json["comment"] ?? 0,
      share: json["share"] ?? 0,
      followup: json["followup"] ?? 0,
      createdAt: DateTime.parse(json["createdAt"]),
      user: UserModel.fromJson(json["user"]),
      feedType: json["feedType"],
      isReacted: json["isReact"],
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String? photo;

  UserModel({
    required this.id,
    required this.name,
    this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      name: json["name"] ?? 'No Name',
      photo: json["photo"],
    );
  }
}

//Comment model
class LiveEventResponse2 {
  final bool? success;
  final String? message;
  final LiveEventData? data;

  LiveEventResponse2({this.success, this.message, this.data});

  factory LiveEventResponse2.fromJson(Map<String, dynamic> json) =>
      LiveEventResponse2(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? LiveEventData.fromJson(json['data']) : null,
      );
}

class LiveEventData {
  final MetaDataComment? meta;
  final List<AllCommentPost>? allCommentPost;

  LiveEventData({this.meta, this.allCommentPost});

  factory LiveEventData.fromJson(Map<String, dynamic> json) => LiveEventData(
    meta:
    json['meta'] != null ? MetaDataComment.fromJson(json['meta']) : null,
    allCommentPost: json['all_comment_post'] != null
        ? List<AllCommentPost>.from(json['all_comment_post']
        .map((x) => AllCommentPost.fromJson(x)))
        : [],
  );
}

class MetaDataComment {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  MetaDataComment({this.page, this.limit, this.total, this.totalPage});

  factory MetaDataComment.fromJson(Map<String, dynamic> json) =>
      MetaDataComment(
        page: json['page'] ?? 1,
        limit: json['limit'] ?? 10,
        total: json['total'] ?? 0,
        totalPage: json['totalPage'] ?? 1,
      );
}


class AllCommentPost {
  final String? id; // Comment ID
  final String? eventPostId;
  final LiveUser? user;
  final String? comment;
  final List<dynamic>? replies;


  RxBool isRepliesVisible = false.obs;

  AllCommentPost({this.id, this.eventPostId, this.user, this.comment, this.replies});

  factory AllCommentPost.fromJson(Map<String, dynamic> json) => AllCommentPost(
    id: json['_id'],
    eventPostId: json['eventpostId'],
    user: json['userId'] != null ? LiveUser.fromJson(json['userId']) : null,
    comment: json['comment'] ?? '',
    replies: json["replies"] == null ? [] : List<dynamic>.from(json["replies"]!.map((x) => x)),
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
