import 'package:flutter_local_database/presentation/posts_page.dart';
import 'package:flutter_local_database/presentation/widget/loading_widget.dart';
import 'package:flutter_local_database/presentation/widget/snackbar_message.dart';

import '../business_logic/cubit/post_cubit.dart';
import '../business_logic/cubit/post_state.dart';
import '../data/models/model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  final int? index;
  final PostCubit cubit;
  const PostAddUpdatePage(this.cubit,
      {this.post, this.isUpdatePost = false, this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBady(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
    );
  }

  _buildBady() {
    return Center(
      child: BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<PostCubit, PostState>(
            listener: (context, state) {
              if (state is UpdatePostState) {
                SnakBarMessage().showSuccessSnackBar(
                    message: "Update Saccsses", context: context);
                Navigator.of(context).pop();
              } else if (state is AddPostState) {
                SnakBarMessage().showSuccessSnackBar(
                    message: "Add Saccsses", context: context);
                Navigator.of(context).pop();
              } else if (state is ErrorPostState) {
                SnakBarMessage()
                    .showErrorSnackBar(message: "Error", context: context);
              }
            },
            builder: (_, state) {
              if (state is LoadingPostState) {
                return const LoadingWidget();
              } else {
                return FormWidget(
                  isUpdatePost: isUpdatePost,
                  post: isUpdatePost ? post : null,
                  index: index,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
