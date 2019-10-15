//Kernino 8/10/2019 V0.1
/*
Class Connection(BuildContext): class for handling the functions and dialogs involved in checking what kind of data connection the phone is on while syncing the db

_context: variable for saving the context used to display

checkConnectivity(): checks data connection:  -in case of WiFi -> _dbSync()
                                              -in case of Mobile Data -> _using4gDialog()
                                              -in case of no connection: Toast "No connection"

_using4GDialog(): Displays a dialog with the question "Continue with mobile data?":   in case of yes -> _dbSync
                                                                                      in case of no -> Toast "Sync cancelled"*/
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Connection
{
  BuildContext _context;

  Connection(BuildContext context):_context=context;

 checkConnectivity()async{
  var connection = await(Connectivity().checkConnectivity());
  if (connection == ConnectivityResult.mobile) {
    _using4GDialog(_context);
  }
  else if (connection == ConnectivityResult.wifi) {
    dbSync();
  }
  else if (connection == ConnectivityResult.none) {
    Fluttertoast.showToast(
        msg: "no connection to data network",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

_using4GDialog (BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Continue with mobile data?'),

          children: <Widget>[
            SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  dbSync();
                },
                child: const Text('Yes')
            ),
            SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Fluttertoast.showToast(
                      msg: "Sync cancelled",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
                child: const Text('no')
            )

          ],
        );
      });
}

dbSync(){
  Fluttertoast.showToast(
      msg: "Sync started",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
}
