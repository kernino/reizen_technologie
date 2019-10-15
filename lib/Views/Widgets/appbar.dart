import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarTest{
  static getAppbar(String title) {

      return AppBar(
        title: Text(
            title,
            style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.red,
      );
  }
}