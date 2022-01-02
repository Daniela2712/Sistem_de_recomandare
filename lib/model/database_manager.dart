import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sistem_de_recomandare/model/users.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_manager.g.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
  // Get all users
  Future<List<User>> getAllUsers() => select(users).get();

  // Add user
  Future insertUser(User user) => into(users).insert(user);

  // Update user
  Future updateUser(User user) => update(users).replace(user);

  // Delete user
  Future deleteUser(User user) => delete(users).delete(user);
}