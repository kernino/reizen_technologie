import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Today'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //the countdown
  dynamic _counter = DateTime(2020, 5, 17).difference(DateTime.now()).inDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), leading: _noodnummersPopup(),),
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

  Widget _noodnummersPopup() => PopupMenuButton<String>(
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'Noodnummers',
        child: Text('Noodnummers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      PopupMenuItem<String>(
          value: 'phone1',
          child: ListTile(
            trailing: Icon(Icons.call),
            title: Text('McDonald\'s '),
            subtitle: Text('011 87 33 88'),
            onTap: () => launch("tel://011873388"),
          )),
      const PopupMenuDivider(),
      PopupMenuItem<String>(
          value: 'phone2',
          child: ListTile(
            trailing: Icon(Icons.call),
            title: Text('Burger King: '),
            subtitle: Text('011 29 86 02'),
            onTap: () => launch("tel://011298602"),
          )),
      const PopupMenuDivider(),
      PopupMenuItem<String>(
        value: 'phone3',
        child: ListTile(
          trailing: Icon(Icons.call),
          title: Text('Stefan Segers: '),
          subtitle: Text('+32 494 08 20 31'),
          onTap: () => launch("tel://+32494082031"),
        ),
      )
    ],
    icon: Icon(Icons.error),
  );
} //+32 494 08 20 31






