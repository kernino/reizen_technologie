import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Database/User.dart';
import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:reizen_technologie/Model/InlogModel.dart';
import 'package:http/http.dart' as http;
import 'package:reizen_technologie/Views/Widgets/inlog_widget.dart';
import 'package:reizen_technologie/Views/Widgets/voorwaarden_widget.dart';
import 'package:reizen_technologie/main.dart';

import '../Views/Widgets/voorwaarden_widget.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

class InlogViewModel implements InlogModel {

  String status, message, api_token, first_name, last_name;
  int traveller_id, trip_id;
  bool isData = false;
  Inlog view = new Inlog();



  void showAlertDialog(BuildContext context, String text) {
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

  void FetchJSON(String username, String password, BuildContext context) async {
    username = username.trim();
    if (username == "" || password == ""){
      showAlertDialog(context, "Geen gebruikersnaam en/of paswoord ingegeven.");
    }
    else{
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
        first_name = responseJSON['first_name'];
        last_name = responseJSON['last_name'];
        traveller_id = responseJSON['traveller_id'];
        trip_id = responseJSON['trip_id'];

        isData = true;
/*      setState(() {
        print('UI Updated');
      });*/
      } else {
        print('Something went wrong. \nResponse Code : ${Response.statusCode}');
      }
      if (status != null && api_token != null && message == null && first_name != null && last_name != null && traveller_id != null){
        //Navigator.of(context).pushReplacementNamed('/screen2');

        var user = User(
            id: 1,
            firstName: first_name,
            lastName: last_name,
            acceptedConditions: 0,
            token: api_token,
            traveller_id: traveller_id,
            trip_id: trip_id);



        await globals.dbHelper.db.insert("users", user.toMap());

        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                new MainDart()));
      }
      else if (status != null && api_token == null && message != null){
        showAlertDialog(context, "Onjuiste inloggegevens gebruikt.");
      }
    }

  }

  @override
  void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VoorwaardenConnection()),
    );
  }

}