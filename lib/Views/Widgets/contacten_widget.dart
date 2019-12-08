import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';
import 'package:reizen_technologie/ViewModel/ContactenViewModel.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactPage extends StatefulWidget {
  ContactPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactPageState createState() => _ContactPageState();

}
class _ContactPageState extends State<ContactPage> {
  List<Map> filteredUsers = List();
  List<Map> filteredUsersNietOphalen = List();
  int i =0;

  Future _future;

  @override
  void initState() {
    super.initState();
    _future = GetTravellers();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Contacten", context),
      body: new FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var content;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return Center(child: CircularProgressIndicator());
            }
            content = snapshot.data;
            i++;
            if(i==1)
              {
                filteredUsers = content;
              }
            filteredUsersNietOphalen = content;

            return new Scaffold(
              body: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        hintText: 'Filter naam',
                      ),
                      onChanged: (string) {
                        setState(() {
                          filteredUsers = filteredUsersNietOphalen
                              .where((u) =>
                          (u['first_name']
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                              u['last_name'].toLowerCase().contains(
                                  string.toLowerCase())))
                              .toList();
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: filteredUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(filteredUsers[index]['first_name'] +
                                        " " +
                                       filteredUsers[index]['last_name'],),
                            subtitle: Text("Nummer: " +
                                        filteredUsers[index]['phone']),
                            onTap: () =>
                                launch("tel://" + filteredUsers[index]['phone']),
                          );
                        },
                        ),
                    )]),
            );
          }),
    );
  }
}