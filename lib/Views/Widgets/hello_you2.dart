import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/ViewModel/HelloYouViewModel.dart';

import 'appbar.dart';


class HelloYou2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarTest.getAppbar("test"),
        body: Text("Logged in! ")
    );
  }
}