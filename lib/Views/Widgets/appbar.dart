import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

class Appbar{

  static getAppbar(String title) {
      return AppBar(
        title: Text(
            title,
            style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.red,
        leading: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Noodnummers',
            child: Text('Noodnummers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          PopupMenuItem<String>(
              value: 'phone1',
              child: ListTile(
                trailing: Icon(Icons.call),
                title: Text(globals.emergencyNumbers[0]['first_name']),
                subtitle: Text('011 87 33 88'),
                onTap: () => launch("tel://011873388"),
              )),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
              value: 'phone2',
              child: ListTile(
                trailing: Icon(Icons.call),
                title: Text('Burger King: '),
                subtitle: Text('011 29 86 02'),
                onTap: () => launch("tel://011298602"),
              )),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'phone3',
            child: ListTile(
              trailing: Icon(Icons.call),
              title: Text('Stefan Segers: '),
              subtitle: Text('+32 494 08 20 31'),
              onTap: () => launch("tel://+32494082031"),
            ),
          )
        ],
        icon: Icon(Icons.error),
      ),
      );
  }
}