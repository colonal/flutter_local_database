import 'package:flutter_local_database/data/models/model.dart';

class PostModel extends Post {
  PostModel(
      {int? postId, int? userId, required String title, required String body})
      : super(postId: postId!, userId: userId!, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        postId: json["id"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": postId,
      "userId": userId,
      "title": title,
      "body": body,
    };
  }
}
