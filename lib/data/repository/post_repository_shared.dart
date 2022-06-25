import 'package:flutter_local_database/data/models/model_shared.dart';
import 'package:flutter_local_database/helpers/shared_preferences_helper/shared_preferences_helper.dart';

import '../models/model.dart';

class PostRepositoryShared {
  final SharedPreferencesHelper sharedPreferencesHelper;

  PostRepositoryShared(this.sharedPreferencesHelper);

  Future<void> initSharedPreferences() async {
    await sharedPreferencesHelper.initSharedPreferences();
  }

  void insertData(List<Post> posts) {
    List<PostShared> postShared = [];

    for (var post in posts) {
      postShared.add(PostShared(
          postId: post.postId,
          userId: post.userId,
          title: post.title,
          body: post.body));
    }

    sharedPreferencesHelper.cachePost(postShared);
  }

  List<Post> getData() {
    return sharedPreferencesHelper.getData();
  }
}
