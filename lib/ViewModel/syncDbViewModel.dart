import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Database/Traveller.dart';
import 'package:reizen_technologie/Views/Widgets/navbar.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/ViewModel/AlgemeneInfoViewModel.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:sqflite/sqflite.dart';

class Sync extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SyncState();
}

class _SyncState extends State<Sync> {

  Future future;


  @override
  void initState() {

    future = syncDbToLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Container();
          case ConnectionState.active:
            return new Container();
          case ConnectionState.waiting:
            return new Container();
          case ConnectionState.done:
            return new Navbar();
        }
        return new Container();
      },
    );

  }
}

Link setConnection(){
  var bearer = globals.loggedInUser[0]["token"];
  print(bearer);
  final HttpLink httpLink =  HttpLink(uri: "http://171.25.229.102:8222/graphql?query=");
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ' + bearer);
  final Link link = authLink.concat(httpLink);
  return link;
}

Future syncDbToLocal() async
{

 var client = GraphQLClient(cache: InMemoryCache(), link: setConnection());

 var result = await client.query(QueryOptions(document: getAllDataToSync()));

 await globals.dbHelper.db.rawDelete("DELETE FROM travellers");

 for (int i = 0; i < result.data['trip'][0]['travellers'].length; i++) {


    Traveller traveller = Traveller(
        first_name: result
            .data['trip'][0]['travellers'][i]['first_name'],
        last_name: result.data['trip'][0]['travellers'][i]['last_name'],
        phone: result.data['trip'][0]['travellers'][i]['phone']
    );

      await globals.dbHelper.db.insert("travellers", traveller.toMap());
 }
}

String getAllDataToSync() {

  int trip_id = globals.loggedInUser[0]["trip_id"];

  String data ="""
    query{
      trip(trip_id:1)
      {
        name, 
        travellers
        {
          first_name, 
          last_name, 
          phone
        }
      }
    }
    """;
  return data;
}
