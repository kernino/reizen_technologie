
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/HelloYouModel.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Views/Widgets/hello_you2.dart';

class HelloYouViewModel implements HelloYouModel {

  @override
  String name;

  @override
  void setName(String string) {
    name = string;
    print("Name: " + name);
  }

  @override
  void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HelloYou2()),
    );
  }

}