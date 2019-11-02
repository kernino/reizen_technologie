import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Appbar {
  static getAppbar(String title, [Widget leadingWidget]) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromRGBO(224, 0, 73, 1.0),
      automaticallyImplyLeading: true,
        /*leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Hotels())),
        )),*/
        leading: leadingWidget,
      actions: <Widget>[
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Noodnummers',
              child: Text('Noodnummers',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            for (var number in globals.emergencyNumbers)
              PopupMenuItem<String>(
                value: 'phone1',
                child: ListTile(
                  trailing: Icon(Icons.call),
                  title: Text(number['first_name'] + ' ' + number["last_name"]),
                  subtitle: Text(number['number']),
                  onTap: () =>
                      launch("tel://" + globals.emergencyNumbers[0]['number']),
                ),
              ),
          ],
          icon: Icon(Icons.error),
        ),
      ],
    );
  }
}
