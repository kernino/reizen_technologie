import 'dart:async';

import 'package:path/path.dart';
import 'package:reizen_technologie/Model/DatabaseTable.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  Database db;

  void initializeDatabase() async {

    db = await openDatabase(
      join(await getDatabasesPath(), 'reizentechnologie.data'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, accepted_conditions INTEGER, token TEXT)",
        );
      },
      version: 2,
    );
  }

  Future<void> insert(DatabaseTable model) async {
    await db.insert(
      model.table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DatabaseTable>> getAll(DatabaseTable model) async {

    final List<Map<String, dynamic>> maps = await db.query(model.table);

    return model.getAll(maps);
  }

  Future<void> update(DatabaseTable model, int id) async {
    // Update the given User.
    await db.update(
      model.table,
      model.toMap(),
      // Ensure that the User has a matching id.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [model.field_id],
    );
  }

  Future<void> delete(DatabaseTable model) async {
    // Remove the User from the database.
    await db.delete(
      model.table,
      // Use a `where` clause to delete a specific User.
      where: "id = ?",
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [model.field_id],
    );
  }
}
