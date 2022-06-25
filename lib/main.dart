import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_database/presentation/home_screen.dart';

import 'business_logic/cubit/my_bloc_observer.dart';
import 'business_logic/cubit/post_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late PostCubit postCubit;
  BlocOverrides.runZoned(
    () {
      postCubit = PostCubit()..initAllData();
    },
    blocObserver: MyBlocObserver(),
  );

  runApp(MyApp(postCubit));
}

class MyApp extends StatelessWidget {
  final PostCubit postCubit;
  const MyApp(this.postCubit, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Local',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => postCubit,
        child: HomeScreen(postCubit),
      ),
    );
  }
}
