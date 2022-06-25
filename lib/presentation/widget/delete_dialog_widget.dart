import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/post_cubit.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  final int index;
  const DeleteDialogWidget(
      {required this.postId, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<PostCubit>(context)
                .deleteData(index: index, postId: postId);
          },
          child: const Text("Yes"),
        )
      ],
    );
  }
}
