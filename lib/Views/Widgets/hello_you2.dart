import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/ViewModel/HelloYouViewModel.dart';



class HelloYou2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Text("Logged in! " + HelloYouViewModel.name)
    );
  }
}