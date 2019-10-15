import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/ViewModel/HelloYouViewModel.dart';



class HelloYou2 extends StatelessWidget {

  final String text;
  HelloYou2({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Text("Api-token: " + text)
    );
  }
}