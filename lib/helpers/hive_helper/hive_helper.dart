import 'package:flutter_local_database/data/models/model_hive.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  late Box posts;
  Future<void> initHive({required String path}) async {
    Hive.init(path);
    Hive.registerAdapter(PostsHiveAdapter());

    await openBox();
  }

  Future<void> openBox() async {
    await Hive.openBox("posts");
    posts = Hive.box("posts");
  }

  void close() {
    Hive.close();
  }

  void insertData(PostsHive post) {
    posts.add(post);
  }

  void deleteData(int index) {
    posts.deleteAt(index);
  }

  void updateData(int index, PostsHive post) {
    posts.putAt(index, post);
  }

  List<PostsHive> getData() {
    final List<PostsHive> allPost = [];
    for (int index = 0; index < posts.length; index++) {
      allPost.add(posts.getAt(index) as PostsHive);
    }

    return allPost;
  }

  Future<void> deteteAllData() async {
    for (int index = 0; index < posts.length; index++) {
      posts.deleteAt(index);
    }
  }
}
