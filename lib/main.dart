//test
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:reizen_technologie/Model/Database/Emergency%20Number.dart';
import 'package:reizen_technologie/Model/Database/User.dart';
import 'package:reizen_technologie/Model/Database/database_helpers.dart';

import 'ViewModel/HelloYouViewModel.dart';
import 'Views/Widgets/appbar.dart';
import 'Views/Widgets/hello_you.dart';
import 'Model/globals.dart' as globals;
import 'Views/Widgets/vandaag_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return new MaterialApp(
        title: 'Hello you',
        theme: new ThemeData(primarySwatch: Colors.blue),
        home: new MainDart());
  }
}

class MainDart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: db(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){
          if (globals.loggedInUser != null)
            {
              return new Vandaag();
            }
          else
            {
              return new HelloYou();
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

  var number = EmergencyNumber(id: 1, user_id: 1, number: "0412345678");

  db.insert(user1);
  db.insert(number);

  List<DatabaseTable> usersList = await db.getAll(user1);

  print(usersList);
  print(await globals.emergencyNumbers);
}
