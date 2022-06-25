// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsHiveAdapter extends TypeAdapter<PostsHive> {
  @override
  final int typeId = 0;

  @override
  PostsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostsHive(
      postId: fields[1] as int,
      userId: fields[3] as int,
      title: fields[2] as String,
      body: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PostsHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.body)
      ..writeByte(1)
      ..write(obj.postId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
