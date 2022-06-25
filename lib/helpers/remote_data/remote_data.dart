import 'dart:convert';

import 'package:flutter_local_database/data/models/model.dart';
import 'package:http/http.dart' as http;

import '../../data/models/post.dart';

const BASE_URL = "https://jsonplaceholder.typicode.com/";

class RemoteData {}

class PostRemoteDateSource {
  late http.Client client;
  PostRemoteDateSource() {
    client = http.Client();
  }

  Future<List<Post>> getAllPost() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postModels =
          decodeJson.map((postJson) => PostModel.fromJson(postJson)).toList();
      return postModels;
    }
    return [];
  }

  Future<void> addPost(Post postModel) async {
    final postJson =
        json.encode({"title": postModel.title, "body": postModel.body});
    await client.post(
      Uri.parse(BASE_URL + "posts/"),
      headers: {"Content-Type": "application/json"},
      body: postJson,
    );
  }

  Future<void> deletePost(int postId) async {
    await client.delete(
      Uri.parse(BASE_URL + "posts/" + postId.toString()),
      headers: {"Content-Type": "application/json"},
    );
  }

  Future<void> updatePost(Post postModel) async {
    final body = json.encode({
      "title": postModel.title,
      "body": postModel.body,
    });
    final response = await client.put(
        Uri.parse(BASE_URL + "posts/" + postModel.postId.toString()),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {}
  }
}
