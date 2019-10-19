import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';

/*class Hotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hotels',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //Color.fromRGBO(255, g, b, opacity),
        //Colors.red,
      ),
      home: HotelsPage(title: 'Hotels'),
    );
  }
}*/ //Moet dit nog in alle pagina's?

class Hotels extends StatefulWidget {
  Hotels({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<Hotels> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Hotels"),
      body: Text("hotels!")
    );
  }
} //+32 494 08 20 31






