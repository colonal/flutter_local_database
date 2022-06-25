import 'dart:ui';

import 'package:flutter_local_database/presentation/widget/loading_widget.dart';

import '../business_logic/cubit/post_cubit.dart';
import '../business_logic/cubit/post_state.dart';
import 'post_add_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widget/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  final PostCubit cubit;
  const PostsPage(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: const Text("Posts"));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const LoadingWidget();
          } else if (state is GetPostState) {
            return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: PostListWidget(cubit, posts: state.posts));
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFloatingButton(context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => PostAddUpdatePage(cubit))));
  }
}
