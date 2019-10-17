import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';


class Vandaag extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reizen technologie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //Color.fromRGBO(255, g, b, opacity),
        //Colors.red,
      ),
      home: VandaagPage(title: 'Today'),
    );
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
} //+32 494 08 20 31






