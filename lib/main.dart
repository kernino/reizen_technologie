import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Connection.dart';
import 'package:reizen_technologie/Model/Database/Car.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:reizen_technologie/Model/Database/DayPlanning.dart';
import 'package:reizen_technologie/Model/Database/Emergency%20Number.dart';
import 'package:reizen_technologie/Model/Database/Hotel.dart';
import 'package:reizen_technologie/Model/Database/User.dart';
import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:reizen_technologie/ViewModel/syncDbViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/navbar.dart';
//import 'package:reizen_technologie/Views/Widgets/hotels_widget.dart';
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
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(primarySwatch: Colors.red),
        home: new MainDart());
  }
}

class MainDart extends StatefulWidget {
  @override
  _MainDartState createState() => _MainDartState();
}

class _MainDartState extends State<MainDart> {
  Future future;
  int i = 0;

  @override
  void initState() {

    DatabaseHelper db = new DatabaseHelper();
    globals.dbHelper = db;





    future = db.initializeDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Container();
          case ConnectionState.active:
            return new Container();
          case ConnectionState.waiting:
            return new Container();
          case ConnectionState.done:
            if (globals.isLoggedIn != true) {
              return new Inlog();
            }
            else if (globals.loggedInUser[0]["accepted_conditions"] == 0) {
              return new VoorwaardenConnection();
            }
            else {
              i++;
              if (i==1) {
              Connection connection = new Connection(context);
              connection.checkConnectivity();}
              return new Navbar();
            }
        }
        return new Container();
      },
    );
  }
}


