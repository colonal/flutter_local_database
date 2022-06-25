import 'package:flutter_local_database/core/error/exceptions.dart';
import 'package:flutter_local_database/data/models/model.dart';
import 'package:flutter_local_database/data/models/model_hive.dart';
import 'package:flutter_local_database/data/models/model_sqflite.dart';
import 'package:flutter_local_database/helpers/hive_helper/hive_helper.dart';
import 'package:flutter_local_database/helpers/sqflit_db_helper/sqflit_db_helper.dart';

class PostRepositorySql {
  final SqflitDBHelper sqflitDBHelper;

  Future<void> initDatabase() async {
    await sqflitDBHelper.initDatabase();
  }

  PostRepositorySql({required this.sqflitDBHelper});
  Future<List<Post>> getPostDataSql() async {
    final posts = await sqflitDBHelper
        .getDataFromDatabase()
        .catchError((_) => throw GetSqflitException());
    return posts.map((post) => PostSqf.fromJson(post)).toList();
  }

  void addPostDataSql(Post post) {
    PostSqf postSqf = PostSqf(
        postId: post.postId,
        userId: post.userId,
        title: post.title,
        body: post.body);
    sqflitDBHelper
        .insertDatabase(postSqf)
        .catchError((_) => throw InsertSqflitException());
  }

  void updatePostDataSql(Post post) {
    PostSqf postSqf = PostSqf(
        postId: post.postId,
        userId: post.userId,
        title: post.title,
        body: post.body);
    sqflitDBHelper
        .updateDataFromDatabase(postSqf)
        .catchError((_) => throw UpdateSqflitException());
  }

  void deletePostDataSql(int id) {
    sqflitDBHelper
        .deletDataFromDatabase(id)
        .catchError((_) => throw DeleteSqflitException());
  }

  void deleteDataAll() async {
    await sqflitDBHelper.deleteAllData();
  }
}
