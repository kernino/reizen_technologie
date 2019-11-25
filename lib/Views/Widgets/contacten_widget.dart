import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';
import 'package:reizen_technologie/ViewModel/ContactenViewModel.dart';


class ContactPage extends StatefulWidget {
  ContactPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Map> filteredUsers = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Contacten"),
      body: new FutureBuilder(
          future: GetTravellers(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var content;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return Center(child: CircularProgressIndicator());
            }
            content = snapshot.data;
            filteredUsers = content;

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
                          filteredUsers = content
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
                    Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                filteredUsers.length, (index) {
                              return Column(
                                children: <Widget>[

                                  InkWell(
                                    child: Center(
                                      child: new Card(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  filteredUsers[index]['first_name'] +
                                                      " " +
                                                      filteredUsers[index]['last_name'],
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),

                                                subtitle: Text("Nummer: " +
                                                    filteredUsers[index]['phone'],
                                                  style: TextStyle(
                                                      fontSize: 18
                                                  ),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ),
                        )),
                  ]),

            );
          }),
    );
  }
}