import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Connection.dart';
import 'package:reizen_technologie/Model/Database/Car.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:reizen_technologie/Model/Database/DayPlanning.dart';
import 'package:reizen_technologie/Model/Database/Emergency%20Number.dart';
import 'package:reizen_technologie/Model/Database/Hotel.dart';
import 'package:reizen_technologie/Model/Database/User.dart';
import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:reizen_technologie/Views/Widgets/voorwaarden_widget.dart';
import 'package:reizen_technologie/ViewModel/DayPlanningViewModel.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';
import 'package:reizen_technologie/ViewModel/CarViewModel.dart';

import 'Model/globals.dart' as globals;
import 'Views/Widgets/inlog_widget.dart';
import 'Views/Widgets/vandaag_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return new MaterialApp(
        title: 'Log in',
        theme: new ThemeData(primarySwatch: Colors.red),
        home: new MainDart());
  }
}

class MainDart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: db(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){

          Connection connection = new Connection(context);
          connection.checkConnectivity();

          if (globals.loggedInUser != null)
            {
              return new Inlog();
            }
          else
            {
              if (globals.loggedInUser[0]["accepted_conditions"] == 0)
                {
                  return new VoorwaardenConnection();
                }
              else
                {
                  return new Vandaag();
                }

            }
    });

  }
}

Future db() async {
  DatabaseHelper db = new DatabaseHelper();

  await db.initializeDatabase();
  await db.GetLoggedInUser();

  var user1 = User(
      id: 1,
      firstName: 'test',
      lastName: 'user',
      acceptedConditions: 0,
      token: 'UkDSHeJHscD3wU5zmnSjXWQKLWZkWAz4vzs4TSuKAQrRXILDSL7iB9qy5Qhy');

  var dayPlanning1 = DayPlanning(
    id: 1,
    name: 'nameTest',
    date: 'dateTest',
    highlight: 'highlightTest',
    description: 'descriptionTest');

  var car1 = Car(
      id: 1,
      car_number: '69',
      size: '5');

  var hotel1 = Hotel(
      id: 1,
      name: 'hotelName',
      description: 'hotelDescription',
      location: 'Schulencity',
      photoUrl: 'hotelPhotoUrl');

  var number = EmergencyNumber(id: 1, user_id: 1, number: "0412345678");

  db.insert(user1);
  db.insert(dayPlanning1);
  db.insert(car1);
  db.insert(hotel1);
  db.insert(number);

  List<DatabaseTable> usersList = await db.getAll(user1);

  GetDayPlannings();
  GetCars();
  GetHotels();
  print(usersList);
  globals.getEmergencyNumbers();
  print(globals.emergencyNumbers);
  //print(await globals.loggedInUser[0]["token"]);
}
