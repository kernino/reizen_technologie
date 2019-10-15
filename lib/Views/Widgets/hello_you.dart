import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reizen_technologie/ViewModel/HelloYouViewModel.dart';

import 'appbar.dart';
import 'hello_you2.dart';

class HelloYou extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelloYouState();
}

class _HelloYouState extends State<HelloYou> {
  @override
  Widget build(BuildContext context) {

    HelloYouViewModel viewModel = new HelloYouViewModel();

    final nameController = TextEditingController();

    return Scaffold(
        appBar: AppbarTest.getAppbar("test"),
        body: new Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    controller: nameController,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      viewModel.setName(nameController.text.trim());
                      viewModel.navigate(context);
                    },
                    child: Text("Login"),
                  ),
                )
              ],
            )));
  }
}
