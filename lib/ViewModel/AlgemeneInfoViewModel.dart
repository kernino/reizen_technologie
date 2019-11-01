import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';
import 'package:reizen_technologie/Model/Database/User.dart';
import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Views/Widgets/navbar.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';

String getAlgemeneData() {
  String data ="""
    query{
      info{
        info_value
      }
    }
    """;
  return data;
}


Link setConnection(){
  var bearer = globals.loggedInUser[0]["token"];
  print(bearer);
  final HttpLink httpLink =  HttpLink(uri: "http://171.25.229.102:8222/graphql?query=");
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ' + bearer);
  final Link link = authLink.concat(httpLink);
  return link;
}

Query getData(){
  Query a = Query(
      options: QueryOptions(document: getAlgemeneData()),
      builder: (QueryResult result, {
        BoolCallback refetch,
        FetchMore fetchMore,
      }) {
        if (result.data == null) {
          //return Text("loading...");
          return Text(result.errors.toString());
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text(result.data['info'][index]['info_value']);
          },
          itemCount: result.data['info'].length,
          scrollDirection: Axis.vertical,
        );
      });
  return a;
}

void acceptConditions(BuildContext context) async {
  await globals.database.update('users', {'accepted_conditions': '1'}, where: 'token = ?', whereArgs: [await globals.loggedInUser[0]["token"]]);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Navbar()),
  );
}



