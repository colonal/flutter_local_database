import 'package:flutter/material.dart';
import '../../business_logic/cubit/post_cubit.dart';
import '../../data/models/model.dart';

import '../post_add_update_page.dart';

class UpdatePostWidget extends StatelessWidget {
  final Post post;
  final PostCubit cubit;
  final int index;
  const UpdatePostWidget(this.cubit,
      {required this.post, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(cubit,
                isUpdatePost: true, post: post, index: index)));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
