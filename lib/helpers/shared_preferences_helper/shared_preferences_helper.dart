import 'dart:convert';

import 'package:flutter_local_database/data/models/model_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';

class SharedPreferencesHelper {
  late SharedPreferences sharedPreferences;
  final key = "post";
  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  List<PostShared> getData() {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostShared> jsonToPostModels = decodeJsonData
          .map((jsonPost) => PostShared.fromJson(jsonPost))
          .toList();
      return jsonToPostModels;
    }
    throw EmptyCacheException();
  }

  void cachePost(List<PostShared> postModel) {
    List postModelToJson = postModel.map((post) => post.toMap()).toList();

    sharedPreferences.setString(key, json.encode(postModelToJson));
  }
}
