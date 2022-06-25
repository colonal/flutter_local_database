import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_database/business_logic/cubit/post_state.dart';
import 'package:flutter_local_database/core/network/network_info.dart';
import 'package:flutter_local_database/data/models/model.dart';
import 'package:flutter_local_database/data/repository/post_repository_shared.dart';
import 'package:flutter_local_database/data/repository/post_repository_sql.dart';
import 'package:flutter_local_database/helpers/hive_helper/hive_helper.dart';
import 'package:flutter_local_database/helpers/sqflit_db_helper/sqflit_db_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/repository/post_repository_hive.dart';
import '../../helpers/remote_data/remote_data.dart';
import '../../helpers/shared_preferences_helper/shared_preferences_helper.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(InitPostState());
  List<Post> posts = [];

  late PostRemoteDateSource postRemoteDateSource;
  late PostRepositoryHive postRepositoryHive;
  late PostRepositoryShared postRepositoryShared;
  late PostRepositorySql postRepositorySql;
  late bool isNetwork = true;
  static PostCubit get(context) => BlocProvider.of(context);

  void initAllData() async {
    print("initAllData");
    emit(LoadingPostState());
    postRemoteDateSource = PostRemoteDateSource();

    postRepositoryHive = PostRepositoryHive(HiveHelper());
    await postRepositoryHive.initHive();

    postRepositoryShared = PostRepositoryShared(SharedPreferencesHelper());
    await postRepositoryShared.initSharedPreferences();

    postRepositorySql = PostRepositorySql(sqflitDBHelper: SqflitDBHelper());
    await postRepositorySql.initDatabase();
    getPosts();
  }

  void getPosts() async {
    print("getPosts");
    final network = NetworkInfoImpl(InternetConnectionChecker());
    isNetwork = await network.isConnected;
    if (isNetwork) {
      await postRemoteDateSource
          .getAllPost()
          .then((value) => posts = value)
          .catchError((_) {
        emit(ErrorPostState());
      });
      postRepositorySql.deleteDataAll();
      postRepositoryHive.deleteAllData();

      for (Post post in posts) {
        postRepositorySql.addPostDataSql(post);
        postRepositoryHive.addPostDataHive(post);
      }

      postRepositoryShared.insertData(posts);
    } else {
      posts = await postRepositorySql.getPostDataSql();
    }

    emit(GetPostState(posts));
  }

  void addData(Post post) async {
    emit(LoadingPostState());
    postRemoteDateSource.addPost(post);
    posts.add(post);
    postRepositorySql.addPostDataSql(post);
    postRepositoryHive.addPostDataHive(post);
    emit(AddPostState());
  }

  void updateData({required Post post, required int index}) {
    emit(LoadingPostState());
    postRemoteDateSource.updatePost(post);
    postRepositorySql.updatePostDataSql(post);
    postRepositoryHive.updataPostDataHive(index, post);
    posts[index] = post;
    emit(UpdatePostState());
  }

  void deleteData({required int index, required int postId}) {
    emit(LoadingPostState());
    postRemoteDateSource.deletePost(postId);
    postRepositorySql.deletePostDataSql(postId);
    postRepositoryHive.deletePostDataHive(index);
    posts.removeAt(index);
    emit(DeletePostState());
  }
}
