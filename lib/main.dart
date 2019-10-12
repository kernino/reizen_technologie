//test
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/DatabaseTable.dart';
import 'package:reizen_technologie/Model/User.dart';
import 'package:reizen_technologie/ViewModel/database_helpers.dart';

import 'Views/Widgets/appbar.dart';
import 'Views/Widgets/hello_you.dart';
import 'Views/Widgets/hello_you2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   db();

    return new MaterialApp(
        title: 'Hello you',
        theme: new ThemeData(
            primarySwatch: Colors.blue
        ),
        home: new MainDart()
    );
  }
}

class MainDart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppbarTest.getAppbar(),
        body: new MaterialApp(
          home: new HelloYou(),
          routes: <String, WidgetBuilder> {
            '/screen1': (BuildContext context) => new HelloYou(),
            '/screen2' : (BuildContext context) => new HelloYou2(),
          },
        )
    );
  }
}
Future db() async {

  DatabaseHelper db = new DatabaseHelper();


  await db.initializeDatabase();

  var user1 = User(
      firstName: 'test',
      lastName: 'user',
      acceptedConditions: 0,
      token: 'UkDSHeJHscD3wU5zmnSjXWQKLWZkWAz4vzs4TSuKAQrRXILDSL7iB9qy5Qhy'
  );


  db.insert(user1);


  List<DatabaseTable> usersList = await db.getAll(user1);

  print(usersList);
}

