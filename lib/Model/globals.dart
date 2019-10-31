library globals.dart;

import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Database/User.dart';

Database database;

DatabaseHelper dbHelper;

var emergencyNumbers  =null;

Future getEmergencyNumbers() async {
 emergencyNumbers = await database.rawQuery("SELECT first_name, last_name, number FROM travellers AS t INNER JOIN emergency_numbers AS e ON t.id = e.traveller_id");
}



var loggedInUser = null;