import 'dart:async';

import 'package:path/path.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;


class DatabaseHelper {

  Database db;

  Future initializeDatabase() async {

    db = await openDatabase(
      join(await getDatabasesPath(), 'database.reizentechnologie'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE trips ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "start_date TEXT,"
              "end_date TEXT,"
              "destination TEXT,"
              "transportation_info TEXT)"
        );

        await db.execute(
          "CREATE TABLE day_planning ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "date TEXT,"
              "highlight TEXT,"
              "description TEXT)"
        );

        await db.execute(
          "CREATE TABLE hotels ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "description TEXT,"
              "location TEXT,"
              "photoUrl TEXT)"
        );

        await db.execute(
          "CREATE TABLE cars ("
              "id INTEGER PRIMARY KEY,"
              "car_number TEXT,"
              "size TEXT)"
        );

        await db.execute(
          "CREATE TABLE rooms ("
              "id INTEGER PRIMARY KEY,"
              "room_number TEXT,"
              "size TEXT)"
        );

        await db.execute(
          "CREATE TABLE travellers ("
              "id INTEGER PRIMARY KEY,"
              "first_name TEXT,"
              "last_name TEXT,"
              "major_name TEXT,"
              "phone TEXT,"
              "room_id INTEGER,"
              "car_id INTEGER,"
              "FOREIGN KEY(room_id) REFERENCES rooms(id),"
              "FOREIGN KEY(car_id) REFERENCES cars(id))"
        );

        await db.execute(
            "CREATE TABLE users ("
                "id INTEGER PRIMARY KEY, "
                "first_name TEXT, "
                "last_name TEXT, "
                "accepted_conditions INTEGER, "
                "token TEXT,"
                "traveller_id INTEGER,"
                "FOREIGN KEY(traveller_id) REFERENCES travellers(id))"
        );

        await db.execute(
            "CREATE TABLE emergency_numbers ("
                "id INTEGER PRIMARY KEY,"
                "user_id INTEGER,"
                "number TEXT,"
                "FOREIGN KEY(user_id) REFERENCES users(id))"
        );
      },
      version: 5,
    );

    globals.database = db;
  }

  Future GetLoggedInUser() async {
    List<Map> result = await db.query("users", columns: ["first_name", "last_name", "accepted_conditions", "token", "traveller_id"], where: "token IS NOT NULL");
    if(result != null) {
      globals.loggedInUser = result;
    }
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
