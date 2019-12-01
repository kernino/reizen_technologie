library globals.dart;

import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Database/User.dart';

Database database;

DatabaseHelper dbHelper;

var emergencyNumbers  =null;

Future getEmergencyNumbers() async {
 emergencyNumbers = await database.query("emergency_numbers");
}

var connected = false;

var loggedInUser = [];

bool isLoggedIn = false;