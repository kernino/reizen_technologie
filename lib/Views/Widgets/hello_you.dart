import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reizen_technologie/ViewModel/HelloYouViewModel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reizen_technologie/Views/Widgets/hello_you2.dart';

showAlertDialog(BuildContext context, String text) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Foutmelding"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class HelloYou extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelloYouState();
}

class _HelloYouState extends State<HelloYou> {

  String status, message, api_token;
  bool isData = false;

  FetchJSON(String username, String password) async {
    String url = 'http://171.25.229.102:8222/api/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"username":"' + username + '","password":"' + password + '"}';
    var Response = await http.post(url, headers: headers, body: json);

    if (Response.statusCode == 200) {
      String responseBody = Response.body;
      var responseJSON = jsonDecode(responseBody);
      status = responseJSON['status'];
      message = responseJSON['message'];
      api_token = responseJSON['api_token'];
      isData = true;
      setState(() {
        print('UI Updated');
      });
    } else {
      print('Something went wrong. \nResponse Code : ${Response.statusCode}');
    }
    if (status != null && api_token != null && message == null){
      //Navigator.of(context).pushReplacementNamed('/screen2');
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new HelloYou2(text: '$api_token')));
    }
    else if (status != null && api_token == null && message != null){
      showAlertDialog(context, "Onjuiste inloggegevens gebruikt.");
    }
  }

  @override
  Widget build(BuildContext context) {
    HelloYouViewModel viewModel = new HelloYouViewModel();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Container(
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
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    controller: usernameController,
                    ),
                  new TextFormField(
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    ),
                  new Text(
                    'Status : $status',
                    style: Theme.of(context).textTheme.title,
                  ),
                  new Text(
                    'api_token : $api_token',
                    style: Theme.of(context).textTheme.title,
                  ),
                  new Text(
                    'Message : $message',
                    style: Theme.of(context).textTheme.title,
                  ),
                  ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  FetchJSON(usernameController.text, passwordController.text);
                },
                child: const Text("Login"),
              ),
            )
          ],
        ));
  }
}
