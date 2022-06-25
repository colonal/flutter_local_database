import 'package:flutter_local_database/data/models/model.dart';

abstract class PostState {}

class InitPostState extends PostState {}

class LoadingPostState extends PostState {}

class InitDataPostState extends PostState {}

class GetPostState extends PostState {
  final List<Post> posts;

  GetPostState(this.posts);
}

class ErrorPostState extends PostState {}

class AddPostState extends PostState {}

class UpdatePostState extends PostState {}

class DeletePostState extends PostState {}
