import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:reizen_technologie/Model/Database/Activity.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:reizen_technologie/Model/Database/Room.dart';
import 'package:reizen_technologie/Model/Database/Traveller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

import '../Connection.dart';
import 'Car.dart';
import 'DayPlanning.dart';
import 'Emergency Number.dart';
import 'Hotel.dart';
import 'RoomTraveller.dart';
import 'TripInfo.dart';


class DatabaseHelper {

  Database db;

  Future initializeDatabase(BuildContext context) async {

    db = await openDatabase(
      join(await getDatabasesPath(), 'data.reizentechnogie.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE remote_update ("
                "id INTEGER PRIMARY KEY,"
                "update_time TEXT)"
        );

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
              "date TEXT,"
              "highlight TEXT,"
              "description TEXT,"
              "location TEXT)"
        );

        await db.execute(
          "CREATE TABLE activities ("
              "id INTEGER PRIMARY KEY,"
              "day_planning_id INTEGER,"
              "name TEXT,"
              "start_hour TEXT,"
              "end_hour TEXT,"
              "description TEXT,"
              "location TEXT,"
              "FOREIGN KEY(day_planning_id) REFERENCES day_planning(id))"
        );

        await db.execute(
          "CREATE TABLE hotels ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "description TEXT,"
              "location TEXT,"
              "photoUrl TEXT,"
              "start_date TEXT,"
              "end_date TEXT)"
        );

        await db.execute(
          "CREATE TABLE cars ("
              "id INTEGER PRIMARY KEY,"
              "size TEXT,"
              "driver_id INTEGER)"
        );

        await db.execute(
          "CREATE TABLE rooms ("
              "id INTEGER PRIMARY KEY,"
              "room_number TEXT,"
              "size TEXT,"
              "hotel_id INTEGER,"
              "FOREIGN KEY(hotel_id) REFERENCES hotels(id))"
        );

        await db.execute(
          "CREATE TABLE travellers ("
              "id INTEGER PRIMARY KEY,"
              "first_name TEXT,"
              "last_name TEXT,"
              "major_name TEXT,"
              "phone TEXT,"
              "driver INTEGER,"
              "car_id INTEGER,"
              "FOREIGN KEY(car_id) REFERENCES cars(id))"
        );

        await db.execute(
          "CREATE TABLE room_traveller ("
              "id INTEGER PRIMARY KEY,"
              "room_id INTEGER,"
              "traveller_id INTEGER,"
              "FOREIGN KEY(room_id) REFERENCES rooms(id),"
              "FOREIGN KEY(traveller_id) REFERENCES travellers(id))"
        );

        await db.execute(
            "CREATE TABLE users ("
                "id INTEGER PRIMARY KEY,"
                "first_name TEXT,"
                "last_name TEXT,"
                "accepted_conditions INTEGER,"
                "token TEXT,"
                "traveller_id INTEGER,"
                "trip_id INTEGER,"
                "FOREIGN KEY(traveller_id) REFERENCES travellers(id),"
                "FOREIGN KEY(trip_id) REFERENCES trips(id))"
        );

        await db.execute(
            "CREATE TABLE emergency_numbers ("
                "id INTEGER PRIMARY KEY,"
                "number TEXT,"
                "first_name TEXT,"
                "last_name TEXT)"
        );

        await db.execute(
            "CREATE TABLE trip_info ("
                "id INTEGER PRIMARY KEY,"
                "info TEXT)"
        );

      },
      version: 3
    );
    await GetLoggedInUser();
    globals.database = db;

    Connection connection = new Connection(context);
    connection.checkConnectivity();
  }

  Future GetLoggedInUser() async {
    List<Map> result = await db.query("users", columns: ["first_name", "last_name", "accepted_conditions", "token", "traveller_id", "trip_id"], where: "token IS NOT NULL");
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



  Future Seed() async {



    /*var dayPlanning1 = DayPlanning(
        id: 1,
        date: '17/05',
        highlight: 'vertrek naar ...',
        description: 'descriptionTest',
        location: 'Location1');

    var dayPlanning2 = DayPlanning(
        id: 2,
        date: '18/05',
        highlight: 'bezoeken van ...',
        description: 'descriptionTest',
        location: 'Location1');

    var dayPlanning3 = DayPlanning(
        id: 3,
        date: '19/05',
        highlight: 'eten bij ...',
        description: 'descriptionTest',
        location: 'Location2');*/


/*    var car1 = Car(id: 1, driver_id: 1);
    var car2 = Car(id: 2, driver_id: 2);
    var car3 = Car(id: 3, driver_id: 3);
    var car4 = Car(id: 4, driver_id: 4);*/
    /*var room1 = Room(hotel_id: 1, room_number: '101');
    var room2 = Room(hotel_id: 1,room_number: '102');
    var room3 = Room(hotel_id: 2,room_number: '103');
    var room4 = Room(hotel_id: 2, room_number: '104');
    var roomTraveller1 = RoomTraveller(room_id: 1,traveller_id: 1);
    var roomTraveller2 = RoomTraveller(room_id: 1,traveller_id: 2);
    var roomTraveller3 = RoomTraveller(room_id: 1,traveller_id: 3);
    var roomTraveller4 = RoomTraveller(room_id: 2,traveller_id: 4);
    var roomTraveller5 = RoomTraveller(room_id: 2,traveller_id: 5);
    var roomTraveller6 = RoomTraveller(room_id: 2,traveller_id: 6);
    var roomTraveller7 = RoomTraveller(room_id: 3,traveller_id: 7);
    var roomTraveller8 = RoomTraveller(room_id: 3,traveller_id: 8);
    var roomTraveller9 = RoomTraveller(room_id: 3,traveller_id: 9);
    var roomTraveller10 = RoomTraveller(room_id: 4,traveller_id: 10);
    var roomTraveller11 = RoomTraveller(room_id: 4,traveller_id: 11);
    var roomTraveller12 = RoomTraveller(room_id: 4,traveller_id: 12);


/*    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [1, 1]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [1, 2]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [1, 3]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [1, 4]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [2, 5]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [2, 6]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [2, 7]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [2, 8]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [3, 9]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [3, 10]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [3, 11]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [3, 12]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [4, 13]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [4, 14]);
    await db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [4, 15]);*/

    /*var traveller1 = Traveller(
      id: 1,
      first_name: 'a',
      last_name: 'test',
      car_id: 1,
        phone: "555"
    );

    var traveller2 = Traveller(
        id: 2,
        first_name: 'b',
        last_name: 'test',
        car_id: 1,
        phone: "555"
    );var traveller3 = Traveller(
        id: 3,
        first_name: 'c',
        last_name: 'test',
        car_id: 1,
        phone: "555"
    );var traveller4 = Traveller(
        id: 4,
        first_name: 'd',
        last_name: 'test',
        car_id: 2,
        phone: "555"
    );var traveller5 = Traveller(
        id: 5,
        first_name: 'e',
        last_name: 'test',
        car_id: 2,
        phone: "555"
    );var traveller6 = Traveller(
        id: 6,
        first_name: 'f',
        last_name: 'test',
        car_id: 2,
        phone: "555"
    );var traveller7 = Traveller(
        id: 7,
        first_name: 'g',
        last_name: 'test',
        car_id: 3,
        phone: "555"
    );var traveller8 = Traveller(
        id: 8,
        first_name: 'h',
        last_name: 'test',
        car_id: 3,
        phone: "555"
    );var traveller9 = Traveller(
        id: 9,
        first_name: 'i',
        last_name: 'test',
        car_id: 3,
        phone: "555"

    );var traveller10 = Traveller(
        id: 10,
        first_name: 'j',
        last_name: 'test',
        car_id: 4,
        phone: "555"
    );var traveller11 = Traveller(
        id: 11,
        first_name: 'k',
        last_name: 'test',
        car_id: 4,
        phone: "555"
    );
*/

//    var hotel1 = Hotel(
//        id: 1,
//        name: 'Schulen Station',
//        description: 'mooi station. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Praesent elementum facilisis leo vel fringilla est. Dictum sit amet justo donec. Diam sit amet nisl suscipit adipiscing bibendum est ultricies integer. Maecenas sed enim ut sem viverra aliquet eget sit amet. Et netus et malesuada fames ac turpis egestas. Turpis massa tincidunt dui ut ornare lectus sit amet. Sit amet justo donec enim diam. Augue ut lectus arcu bibendum at varius vel pharetra vel. Mauris vitae ultricies leo integer malesuada nunc. Nibh cras pulvinar mattis nunc sed. Amet risus nullam eget felis eget nunc lobortis. Aliquam malesuada bibendum arcu vitae elementum curabitur vitae. Integer feugiat scelerisque varius morbi. Proin sagittis nisl rhoncus mattis rhoncus urna neque. Sed risus ultricies tristique nulla aliquet enim tortor. Sem integer vitae justo eget magna. Iaculis urna id volutpat lacus laoreet non curabitur gravida. Ornare massa eget egestas purus viverra. Mauris ultrices eros in cursus turpis massa tincidunt dui. \n\nSollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Sagittis nisl rhoncus mattis rhoncus urna neque viverra justo. Enim nulla aliquet porttitor lacus luctus. Tincidunt id aliquet risus feugiat. Adipiscing at in tellus integer feugiat scelerisque varius morbi. Nisl nunc mi ipsum faucibus vitae aliquet nec. Et tortor consequat id porta nibh venenatis. Tincidunt ornare massa eget egestas purus viverra accumsan. Ac tortor vitae purus faucibus ornare. Consequat ac felis donec et odio pellentesque. Rhoncus aenean vel elit scelerisque mauris. Aliquam id diam maecenas ultricies mi eget mauris. Neque convallis a cras semper auctor neque vitae tempus quam.',
//        location: 'Schulencity',
//        photoUrl: 'assets/hotels/hotel0.jpg',
//        start_date: '2019-11-2',
//        end_date: '2019-11-9');
//
//    var hotel2 = Hotel(
//        id: 2,
//        name: 'C-mine',
//        description: 'mooie mijn',
//        location: 'Genk',
//        photoUrl: 'assets/hotels/hotel1.jpg',
//        start_date: '2019-11-9',
//        end_date: '2019-11-11');
//
//    var hotel3 = Hotel(
//        id: 3,
//        name: 'Hilton',
//        description: 'Hotel in New York',
//        location: 'New York',
//        photoUrl: 'assets/hotels/hotel2.jpg',
//        start_date: '2020-05-19',
//        end_date: '2020-05-20');

    /*var activity1 = Activity(
      id: 1,
      day_planning_id: 1,
      start_hour: "08:00",
      end_hour: "09:00",
      description: "activity 1 description...",
      location: "activity 1 location...",
      name: "Activity 1"
    );

    var activity2 = Activity(
        id: 2,
        day_planning_id: 1,
        start_hour: "09:00",
        end_hour: "10:00",
        description: "activity 2 description...",
        location: "activity 2 location...",
        name: "Activity 2"
    );*/

   /* var number1 = EmergencyNumber(id: 1, traveller_id: 1, number: "0412345678");
    var number2 = EmergencyNumber(id: 2, traveller_id: 2, number: "0498765432");*/

    /*db.insert("day_planning", dayPlanning1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("day_planning", dayPlanning2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("day_planning", dayPlanning3.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);*/
    /*
    insert(dayPlanning4);
    insert(dayPlanning5);
    insert(dayPlanning6);
    insert(dayPlanning7);
    insert(dayPlanning8);
    */
    /*db.insert("cars", car1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("cars", car2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("cars", car3.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("cars", car4.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);*/
    /*db.insert("travellers", traveller1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller3.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller4.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller5.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller6.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller7.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller8.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller9.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller10.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("travellers", traveller11.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);*/
//    db.insert("hotels", hotel1.toMap(),
//        conflictAlgorithm: ConflictAlgorithm.replace);
//    db.insert("hotels", hotel2.toMap(),
//        conflictAlgorithm: ConflictAlgorithm.replace);
//    db.insert("hotels", hotel3.toMap(),
//        conflictAlgorithm: ConflictAlgorithm.replace);
    await globals.dbHelper.db.rawDelete("DELETE FROM rooms");
    await globals.dbHelper.db.rawDelete("DELETE FROM room_traveller");
    db.insert("rooms", room1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("rooms", room2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("rooms", room3.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("rooms", room4.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller3.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller4.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller5.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller6.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller7.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller8.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller9.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller10.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller11.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("room_traveller", roomTraveller12.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    /*db.insert("activities", activity1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("activities", activity2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);*/
    /*db.insert("emergency_numbers", number1.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    db.insert("emergency_numbers", number2.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    */

    print(await db.query("travellers", columns: ["first_name", "last_name", "phone"]));*/
  }
}
