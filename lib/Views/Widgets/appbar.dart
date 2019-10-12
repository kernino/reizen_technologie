import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarTest{
  static getAppbar() {

      return AppBar(
        title: Text(
            'Test',
            style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.red,
      );
  }
}