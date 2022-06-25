import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_database/presentation/widget/snackbar_message.dart';

import '../../business_logic/cubit/post_cubit.dart';
import '../../business_logic/cubit/post_state.dart';
import '../posts_page.dart';
import 'delete_dialog_widget.dart';
import 'loading_widget.dart';

class DeletePostWidget extends StatelessWidget {
  final int postId;
  final int index;
  final PostCubit cubit;
  const DeletePostWidget(this.cubit,
      {required this.postId, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => deleteDialog(context),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
      icon: const Icon(Icons.delete),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(context) {
    showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: cubit,
            child: BlocConsumer<PostCubit, PostState>(
              listener: (context, state) {
                if (state is DeletePostState) {
                  SnakBarMessage().showSuccessSnackBar(
                      message: "state.message", context: context);
                  Navigator.of(context).pop();
                } else if (state is ErrorPostState) {
                  Navigator.of(context).pop();
                  SnakBarMessage()
                      .showErrorSnackBar(message: "Erroe", context: context);
                }
              },
              builder: (context, state) {
                if (state is LoadingPostState) {
                  return const AlertDialog(
                    title: LoadingWidget(),
                  );
                }
                return DeleteDialogWidget(postId: postId, index: index);
              },
            ),
          );
        });
  }
}
