import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:pet_parent/src/database/db_service.dart';

import '../models/user_model.dart';

class PetparentDB {
  final tableUsers = 'Users';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableUsers(
      "id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""");
  }

  Future<int> registerUser(
      {required String name,
      required String password,
      required String email}) async {
    final database = await DataBaseService().database;

    if (database != null) {
      return await database.rawInsert(
          '''INSERT INTO $tableUsers (name, email, password) VALUES (?, ?, ?)''',
          [name, email, password]);
    }
    return 0;
  }

  Future<List<User>> fetchAll() async {
    final database = await DataBaseService().database;

    final users = await database
        ?.rawQuery('''SELECT * FROM $tableUsers ORDER BY (name) ASC''');
    return users!.map((user) => User.fromSqfliteDatabase(user)).toList();
  }

  Future<User> fetchById(int id) async {
    final database = await DataBaseService().database;

    final user = await database
        ?.rawQuery('''SELECT * FROM $tableUsers WHERE id = ?''', [id]);
    return User.fromSqfliteDatabase(user!.first);
  }

  Future<User?> fetchUserByEmail(String email) async {
    final database = await DataBaseService().database;
    final users = await database
        ?.rawQuery('''SELECT * FROM $tableUsers WHERE email = ?''', [email]);

    if (users != null && users.isNotEmpty) {
      return User.fromSqfliteDatabase(users.first);
    }
    return null;
  }

  Future<int> updatePassword({required int id, String? password}) async {
    final database = await DataBaseService().database;

    return await database!.update(
      tableUsers,
      {
        if (password != null) 'password': password,
      },
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  Future<void> delete(int id) async {
    final database = await DataBaseService().database;
    await database?.rawDelete('''DELETE FROM $tableUsers WHERE id = ?''', [id]);
  }
}
