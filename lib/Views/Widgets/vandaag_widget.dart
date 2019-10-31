import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;


class Vandaag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: globals.dbHelper.Seed(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return MaterialApp(
            title: 'vandaag',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              //Color.fromRGBO(255, g, b, opacity),
            ),
            home: VandaagPage(title: 'Today'),
          );

        });
  }
}

class VandaagPage extends StatefulWidget {
  VandaagPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VandaagPageState createState() => _VandaagPageState();
}

class _VandaagPageState extends State<VandaagPage> {
  //the countdown
  dynamic _counter = DateTime(2020, 5, 17).difference(DateTime.now()).inDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Vandaag"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Time until departure:',
            ),
            Text(
              '$_counter' + ' days',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}





