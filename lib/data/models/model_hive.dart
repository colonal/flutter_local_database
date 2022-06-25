import 'package:flutter_local_database/data/models/model.dart';
import 'package:hive/hive.dart';

part 'model_hive.g.dart';

@HiveType(typeId: 0)
class PostsHive extends Post {
  PostsHive(
      {required int postId,
      required int userId,
      required String title,
      required String body})
      : super(postId: postId, userId: userId, title: title, body: body);

  @HiveField(0)
  @override
  String get body;

  @HiveField(1)
  @override
  int get postId;

  @HiveField(2)
  @override
  String get title;

  @HiveField(3)
  @override
  int get userId;

  factory PostsHive.fromJson(Map<String, dynamic> json) {
    return PostsHive(
        postId: json["postId"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "userId": userId,
      "title": title,
      "body": body,
    };
  }
}
