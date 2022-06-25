import 'package:flutter/material.dart';
import 'package:flutter_local_database/presentation/widget/post_detail_widget.dart';

import '../business_logic/cubit/post_cubit.dart';
import '../data/models/model.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  final int index;
  final PostCubit cubit;
  const PostDetailPage(this.cubit,
      {Key? key, required this.post, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Post Detail"),
    );
  }

  _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostsDetailWidget(cubit, post: post, index: index),
      ),
    );
  }
}
