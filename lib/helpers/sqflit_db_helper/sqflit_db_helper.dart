// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_local_database/core/error/exceptions.dart';
import 'package:flutter_local_database/data/models/model_sqflite.dart';
import 'package:flutter_local_database/helpers/get_path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../core/constnats/sql_string.dart';
import 'package:path/path.dart' as Path;

class SqflitDBHelper {
  late Database database;

  Future<void> initDatabase() async {
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
    }
    String path = await GetPath().call();
    path = Path.join(path, dbName);
    database =
        await openDatabase(path, version: 1, onCreate: (database, varsion) {
      database.execute(sqlCreateTable);
      print("Create Table");
    }, onOpen: (database) {
      print("Database Open");
    }).catchError((_) {
      throw InitSqflitException();
    });
    print("path : $path");
  }

  Future<void> insertDatabase(PostSqf post) async {
    database
        .rawInsert(sqlInsert, [post.postId, post.userId, post.title, post.body])
        .then((value) {})
        .catchError((_) => throw InsertSqflitException());
  }

  Future<List<Map>> getDataFromDatabase() async {
    final List<Map> data = await database
        .rawQuery(sqlGetData)
        .catchError((_) => throw GetSqflitException());
    return data;
  }

  Future<void> deletDataFromDatabase(int id) async {
    database
        .rawDelete(sqlDeleteData, [id])
        .then((value) => print("Delete: $value"))
        .catchError((_) => throw DeleteSqflitException());
  }

  Future<void> updateDataFromDatabase(PostSqf post) async {
    database
        .rawUpdate(sqlUpdateData, [post.title, post.body, post.postId])
        .then((value) => print("update: $value"))
        .catchError((_) => throw DeleteSqflitException());
  }

  Future<void> deleteAllData() async {
    await database.rawDelete(sqlDeleteAllData);
  }
}
