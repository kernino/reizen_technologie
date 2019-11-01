import 'dart:async';

import 'package:path/path.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:reizen_technologie/Model/Database/Room.dart';
import 'package:reizen_technologie/Model/Database/Traveller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

import 'Car.dart';
import 'DayPlanning.dart';
import 'Emergency Number.dart';
import 'Hotel.dart';


class DatabaseHelper {

  Database db;

  Future initializeDatabase() async {

    db = await openDatabase(
      join(await getDatabasesPath(), 'reizentechnogie.database'),
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
                "traveller_id INTEGER,"
                "FOREIGN KEY(traveller_id) REFERENCES travellers(id))"
        );
      },
      version: 5,
    );
    await GetLoggedInUser();
    globals.database = db;
  }

  Future GetLoggedInUser() async {
    List<Map> result = await db.query("users", columns: ["first_name", "last_name", "accepted_conditions", "token", "traveller_id"], where: "token IS NOT NULL");
    if(result[0] != null) {
      globals.loggedInUser = result;
      globals.isLoggedIn = true;
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

  Future Seed() async {



    var dayPlanning1 = DayPlanning(
        id: 1,
        name: 'vertrek naar ...',
        date: '17/05',
        highlight: 'highlightTest',
        description: 'descriptionTest');

    var dayPlanning2 = DayPlanning(
        id: 2,
        name: 'bezoeken van ...',
        date: '18/05',
        highlight: 'highlightTest',
        description: 'descriptionTest');

    var dayPlanning3 = DayPlanning(
        id: 3,
        name: 'eten bij ...',
        date: '19/05',
        highlight: 'highlightTest',
        description: 'descriptionTest');

    var car1 = Car(id: 1, car_number: '69', size: '5');

    var hotel1 = Hotel(
        id: 1,
        name: 'Schulen Station',
        description: 'mooi station',
        location: 'Schulencity',
        photoUrl: 'hotelPhotoUrl');

    var hotel2 = Hotel(
        id: 2,
        name: 'C-mine',
        description: 'mooie mijn',
        location: 'Genk',
        photoUrl: 'hotelPhotoUrl');

    var room1 = Room(
      id: 1,
      room_number: "1",
      size: "4"
    );

    var traveller = Traveller(
        id: 1,
        first_name: "Stefan",
        last_name: "Segers",
        major_name: null,
        room_id: 1,
        car_id: 1
    );

    var number = EmergencyNumber(id: 1, traveller_id: 1, number: "0412345678");

    insert(dayPlanning1);
    insert(dayPlanning2);
    insert(dayPlanning3);
    insert(car1);
    insert(hotel2);
    insert(hotel1);
    insert(room1);
    insert(traveller);
    insert(number);
    globals.getEmergencyNumbers();
  }
}
