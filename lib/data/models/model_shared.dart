import 'package:flutter_local_database/data/models/model.dart';

class PostShared extends Post {
  PostShared(
      {int? postId, int? userId, required String title, required String body})
      : super(
            postId: postId ?? 0, userId: userId ?? 0, title: title, body: body);

  factory PostShared.fromJson(Map<String, dynamic> json) {
    return PostShared(
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
