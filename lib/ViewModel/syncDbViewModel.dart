import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Database/Activity.dart';
import 'package:reizen_technologie/Model/Database/DayPlanning.dart';
import 'package:reizen_technologie/Model/Database/Emergency%20Number.dart';
import 'package:reizen_technologie/Model/Database/Hotel.dart';
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
 await globals.dbHelper.db.rawDelete("DELETE FROM hotels");
 await globals.dbHelper.db.rawDelete("DELETE FROM emergency_numbers");

//travellers
 for (int i = 0; i < result.data['trip'][0]['travellers'].length; i++) {


    Traveller traveller = Traveller(
        first_name: result
            .data['trip'][0]['travellers'][i]['first_name'],
        last_name: result.data['trip'][0]['travellers'][i]['last_name'],
        phone: result.data['trip'][0]['travellers'][i]['phone']
    );

      await globals.dbHelper.db.insert("travellers", traveller.toMap());
 }

 //hotels
 for(int i = 0; i < result.data['trip'][0]['hotels'].length; i++){
   Hotel hotel = Hotel(
       name: result
           .data['trip'][0]['hotels'][i]['hotel_name'],
       location: result.data['trip'][0]['hotels'][i]['address'],
       photoUrl: "",
     description: "test",
     start_date: "2019-11-9",
     end_date: "2019-11-12",
   );
   await globals.dbHelper.db.insert("hotels", hotel.toMap());
 }

 //activities
  /*for(int i = 0; i < result.data['trip'][0]['activities'].length; i++){
    Activity activity = Activity(
      name: result
          .data['trip'][0]['activities'][i]['name'],
      location: result.data['trip'][0]['activities'][i]['location'],
      start_hour: result.data['trip'][0]['activities'][i]['start_hour'],
      end_hour: result.data['trip'][0]['activities'][i]['end_hour'],
      description: result.data['trip'][0]['activities'][i]['description'],
    );
    await globals.dbHelper.db.insert("activities", activity.toMap());
  }

  //day_planning
  for(int i = 0; i < result.data['trip'][0]['day_planning'].length; i++){
    DayPlanning dayPlanning = DayPlanning(
      date: result.data['trip'][0]['day_planning'][i]['date'],
      highlight: result.data['trip'][0]['day_planning'][i]['highlight'],
      location: result.data['trip'][0]['day_planning'][i]['location'],
      description: result.data['trip'][0]['day_planning'][i]['description'],
    );
    await globals.dbHelper.db.insert("day_planning", dayPlanning.toMap());
  }*/
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
        },
        hotels
        {
          hotel_name,
          address,
          picture1_link
        }
        
      }
    }
    """;

  /*
        activities
        {
          name,
          start_hour,
          end_hour,
          description,
          location
        }
        day_planning
        {
          date,
          highlight,
          description,
          location
        }
   */
  return data;
}
