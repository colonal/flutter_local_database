import 'package:flutter_local_database/data/models/post.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/post_cubit.dart';
import '../../data/models/model.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  final int? index;
  const FormWidget(
      {required this.isUpdatePost, this.post, Key? key, this.index})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              controller: _titleController, name: "Title", multiLine: false),
          TextFormFieldWidget(
              controller: _bodyController, name: "Body", multiLine: true),
          FormSubmitBtn(
              isUpdate: widget.isUpdatePost,
              onPressed: validateFormThenUpdateOrAddPost),
        ],
      ),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = PostModel(
          userId: widget.isUpdatePost ? widget.post!.userId : 0,
          postId: widget.isUpdatePost ? widget.post!.postId : 0,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isUpdatePost) {
        PostCubit.get(context).updateData(post: post, index: widget.index!);
      } else {
        PostCubit.get(context).addData(post);
      }
    }
  }
}
