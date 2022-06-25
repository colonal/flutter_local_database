import 'package:flutter_local_database/data/models/model.dart';

class PostSqf extends Post {
  final int? id;

  const PostSqf(
      {this.id,
      required postId,
      required userId,
      required title,
      required body})
      : super(postId: postId, userId: userId, title: title, body: body);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "postId": postId,
      "userId": userId,
      "title": title,
      "body": body
    };
  }

  factory PostSqf.fromJson(Map json) {
    return PostSqf(
        id: json["id"],
        postId: json["postId"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"]);
  }
}
