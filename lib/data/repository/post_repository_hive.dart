import 'package:flutter_local_database/helpers/get_path.dart';

import '../../helpers/hive_helper/hive_helper.dart';
import '../models/model.dart';
import '../models/model_hive.dart';

class PostRepositoryHive {
  final HiveHelper hiveHelper;

  Future<void> initHive() async {
    final path = await GetPath().call();
    await hiveHelper.initHive(path: path);
  }

  PostRepositoryHive(this.hiveHelper);
  List<Post> getPostDataHive(List posts) {
    return hiveHelper.getData();
  }

  void addPostDataHive(Post post) {
    PostsHive posth = PostsHive(
        postId: post.postId,
        userId: post.userId,
        title: post.title,
        body: post.body);
    hiveHelper.insertData(posth);
  }

  void updataPostDataHive(int index, Post post) {
    PostsHive posth = PostsHive(
        postId: post.postId,
        userId: post.userId,
        title: post.title,
        body: post.body);
    hiveHelper.updateData(index, posth);
  }

  void deletePostDataHive(int index) {
    hiveHelper.deleteData(index);
  }

  void deleteAllData() async {
    await hiveHelper.deteteAllData();
  }
}
