
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/HelloYouModel.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

class HelloYouViewModel implements HelloYouModel {

  static String name;


  void setName(String string) {
    name = string;
    print("Name: " + name);
  }

  Scaffold checkLoggedIn(BuildContext context) {

  }

}