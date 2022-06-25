import '../../business_logic/cubit/post_cubit.dart';
import '../../data/models/model.dart';
import 'delete_post_btn_widget.dart';
import 'update_post_btn_widget.dart';
import 'package:flutter/material.dart';

class PostsDetailWidget extends StatelessWidget {
  final Post post;
  final int index;
  final PostCubit cubit;
  const PostsDetailWidget(this.cubit,
      {required this.post, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 50),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostWidget(cubit, post: post, index: index),
              DeletePostWidget(
                cubit,
                postId: post.postId,
                index: index,
              ),
            ],
          )
        ],
      ),
    );
  }
}
