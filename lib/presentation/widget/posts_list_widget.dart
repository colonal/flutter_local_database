import 'package:flutter/material.dart';

import '../../business_logic/cubit/post_cubit.dart';
import '../../data/models/model.dart';
import '../post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  final PostCubit cubit;
  const PostListWidget(this.cubit, {required this.posts, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(thickness: 1),
      itemCount: posts.length,
      itemBuilder: (_, index) {
        return ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostDetailPage(
                    cubit,
                    post: posts[index],
                    index: index,
                  ))),
          leading: Text(
            posts[index].postId.toString(),
          ),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        );
      },
    );
  }
}
