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
              return CircularProgressIndicator();
            }
            content = snapshot.data;

            return new Scaffold(
              body: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(content.length, (index) {

                      return Column(
                        children: <Widget>[
                          InkWell(
                            child: Center(
                              child: new Card(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(content[index]['first_name'] + " " + content[index]['last_name'],
                                          style: TextStyle(
                                              fontSize: 18
                                          ),
                                        ),

                                        subtitle: Text("Nummer: " +
                                          content[index]['phone'],
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
                ),
              ),
            );
          }),
    );
  }
}