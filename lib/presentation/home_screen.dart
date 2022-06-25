import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_database/business_logic/cubit/post_cubit.dart';
import 'package:flutter_local_database/business_logic/cubit/post_state.dart';
import 'package:flutter_local_database/presentation/post_add_update_page.dart';
import 'package:flutter_local_database/presentation/widget/loading_widget.dart';
import 'package:flutter_local_database/presentation/widget/posts_list_widget.dart';

class HomeScreen extends StatelessWidget {
  final PostCubit cubit;
  const HomeScreen(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (_, __) {},
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppbar(),
          body: _buildBody(),
          floatingActionButton: _buildFloatingButton(context),
        );
      },
    );
  }

  Widget body() {
    return Container();
  }

  AppBar _buildAppbar() => AppBar(title: const Text("Posts"));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const LoadingWidget();
          } else if (state is GetPostState ||
              PostCubit.get(context).posts.isNotEmpty) {
            return Column(
              children: [
                if (!PostCubit.get(context).isNetwork)
                  Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.red[900]!.withOpacity(0.9),
                    child: const Center(
                        child: Text(
                      "No Network",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: PostListWidget(cubit,
                      posts: PostCubit.get(context).posts),
                )),
              ],
            );
          }
          return _noData();
        },
      ),
    );
  }

  Widget _buildFloatingButton(context) {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PostAddUpdatePage(cubit)));
        });
  }

  Widget _noData() {
    return const Center(
        child: Text(
      "No Data",
      style: TextStyle(color: Colors.black, fontSize: 30),
    ));
  }
}
