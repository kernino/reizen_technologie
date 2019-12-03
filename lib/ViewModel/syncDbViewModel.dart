import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reizen_technologie/Model/Database/Activity.dart';
import 'package:reizen_technologie/Model/Database/Car.dart';
import 'package:reizen_technologie/Model/Database/DayPlanning.dart';
import 'package:reizen_technologie/Model/Database/Emergency%20Number.dart';
import 'package:reizen_technologie/Model/Database/Hotel.dart';
import 'package:reizen_technologie/Model/Database/RemoteUpdate.dart';
import 'package:reizen_technologie/Model/Database/Room.dart';
import 'package:reizen_technologie/Model/Database/RoomTraveller.dart';
import 'package:reizen_technologie/Model/Database/Traveller.dart';
import 'package:reizen_technologie/Model/Database/TripInfo.dart';
import 'package:reizen_technologie/Views/Widgets/navbar.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/ViewModel/VoorwaardenViewModel.dart';
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
  final HttpLink httpLink =  HttpLink(uri: "http://171.25.229.102:8222/graphql2?query=");
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ' + bearer);
  final Link link = authLink.concat(httpLink);
  return link;
}

Future checkUpdate() async
{
  var client = GraphQLClient(cache: InMemoryCache(), link: setConnection());

  var result = await client.query(QueryOptions(document: """
    query{latest}"""));

  List<Map> oldUpdateDate = await globals.dbHelper.db.query("remote_update");

  if (oldUpdateDate.length == 0)
  {
    RemoteUpdate update = new RemoteUpdate(
        update_time: result.data['latest']
    );
    await globals.dbHelper.db.insert("remote_update", update.toMap());
  }
  else if (oldUpdateDate[0]["update_time"] != result.data['latest']) {

      RemoteUpdate update = new RemoteUpdate(
          update_time: result.data['latest']
      );

      await syncDbToLocal();

      await globals.dbHelper.db.rawUpdate("UPDATE remote_update SET update_time = ? WHERE id = ?",  [result.data['latest'], oldUpdateDate[0]["id"]]);
  }
  else{
    Fluttertoast.showToast(
        msg: "App is up to date :)",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

Future syncDbToLocal() async
{
  Fluttertoast.showToast(
      msg: "Sync started",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );

 var client = GraphQLClient(cache: InMemoryCache(), link: setConnection());

 var result = await client.query(QueryOptions(document: getAllDataToSync()));

 await globals.dbHelper.db.rawDelete("DELETE FROM travellers");
 await globals.dbHelper.db.rawDelete("DELETE FROM hotels");
 await globals.dbHelper.db.rawDelete("DELETE FROM rooms");
 await globals.dbHelper.db.rawDelete("DELETE FROM room_traveller");
 await globals.dbHelper.db.rawDelete("DELETE FROM emergency_numbers");
 await globals.dbHelper.db.rawDelete("DELETE FROM cars");
 await globals.dbHelper.db.rawDelete("DELETE FROM trip_info");
await globals.dbHelper.db.rawDelete("DELETE FROM day_planning");
await globals.dbHelper.db.rawDelete("DELETE FROM activities");
//travellers
 for (int i = 0; i < result.data['trip']['travellers'].length; i++) {


    Traveller traveller = Traveller(
        id: int.parse(result.data['trip']['travellers'][i]["traveller_id"]),
        first_name: result.data['trip']['travellers'][i]['first_name'],
        last_name: result.data['trip']['travellers'][i]['last_name'],
        phone: result.data['trip']['travellers'][i]['phone']
    );

      await globals.dbHelper.db.insert("travellers", traveller.toMap());
 }

 //hotels
   for(int i = 0; i < result.data['trip']['hotels'].length; i++){
     Hotel hotel = Hotel(
         id: int.parse(result.data['trip']['hotels'][i]['hotel_id']),
         name: result.data['trip']['hotels'][i]['hotel_name'],
         location: result.data['trip']['hotels'][i]['address'],
         photoUrl: result.data['trip']['hotels'][i]['picture1_link'],
         description: "test",
         start_date: result.data['trip']['hotels'][i]['hoteltrips'][0]["start_date"],
         end_date: result.data['trip']['hotels'][i]['hoteltrips'][0]["end_date"],
     );

     await globals.dbHelper.db.insert("hotels", hotel.toMap());

     for(int j=0; j< result.data['trip']['hotels'][i]['hoteltrips'][0]['rooms'].length; j++){
       Room room = Room(
         id: int.parse(result.data['trip']['hotels'][i]['hoteltrips'][0]['rooms'][j]["room_id"]),
         size: result.data['trip']['hotels'][i]['hoteltrips'][0]['rooms'][j]["size"].toString(),
         hotel_id: int.parse(result.data['trip']['hotels'][i]['hotel_id'])
       );

       await globals.dbHelper.db.insert("rooms", room.toMap());

       for (int k =0; k < result.data['trip']['hotels'][i]['hoteltrips'][0]['rooms'][j]["travellers"].length; k++)
       {
         RoomTraveller roomTraveller = RoomTraveller(
           room_id: int.parse(result.data['trip']['hotels'][i]['hoteltrips'][0]['rooms'][j]["room_id"]),
           traveller_id: int.parse(result.data['trip']['hotels'][i]['hoteltrips'][0]['rooms'][j]["travellers"][k]["traveller_id"])
         );

         await globals.dbHelper.db.insert("room_traveller", roomTraveller.toMap());
       }
     }
   }

  for(int i = 0; i < result.data['trip']['dayplannings'].length; i++){
    DayPlanning dayPlanning = DayPlanning(
      date: result.data['trip']['dayplannings'][i]['date'],
      highlight: "test",
      location: result.data['trip']['dayplannings'][i]['location'],
      description: result.data['trip']['dayplannings'][i]['description'],
    );
    await globals.dbHelper.db.insert("day_planning", dayPlanning.toMap());

    for(int j = 0; j < result.data['trip']['dayplannings'][i]['activities'].length; j++){
      Activity activity = Activity(
        name: result.data['trip']['dayplannings'][i]['activities'][j]['name'],
        location: "test",
        start_hour: result.data['trip']['dayplannings'][i]['activities'][j]['start_hour'],
        end_hour: result.data['trip']['dayplannings'][i]['activities'][j]['end_hour'],
        description: "test",
      );
      await globals.dbHelper.db.insert("activities", activity.toMap());
    }
  }

  for(int i=0; i< result.data['trip']['transports'].length; i++) {

    Car car = Car(
        id: i+1,
        size: result.data['trip']['transports'][i]["size"].toString(),
        driver_id: result.data['trip']['transports'][i]["driver_id"]
    );

    await globals.dbHelper.db.insert("cars", car.toMap());

    for (int j=0; j<result.data['trip']['transports'][i]['travellers'].length; j++) {
        int id = int.parse(result.data['trip']['transports'][i]['travellers'][j]["traveller_id"]);
        await globals.dbHelper.db.rawUpdate("UPDATE travellers SET car_id = ? WHERE id = ?", [car.id, id]);
    }
  }

  for(int i=0; i< result.data['trip']['emergencynumbers'].length; i++) {

    EmergencyNumber emergencyNumber = EmergencyNumber(
        number: result.data['trip']['emergencynumbers'][i]["number"],
        first_name: result.data['trip']['emergencynumbers'][i]["first_name"],
        last_name: result.data['trip']['emergencynumbers'][i]["last_name"]
    );

    await globals.dbHelper.db.insert("emergency_numbers", emergencyNumber.toMap());
  }

  await globals.getEmergencyNumbers();


  //trip info
  TripInfo tripInfo = TripInfo(info: result.data['info']['info_value']);
  await globals.dbHelper.db.insert("trip_info", tripInfo.toMap());
}



String getAllDataToSync() {

  int trip_id = globals.loggedInUser[0]["trip_id"];

  String data ="""
    query{
      info(info_name: "algemene_info")
      {
        info_value
      }
      trip(trip_id: 1) {
        name
        travellers {
          traveller_id
          first_name
          last_name
          phone
        }
        hotels {
          hotel_id, 
          hotel_name, 
          address, 
          picture1_link, 
          hoteltrips {
            id, 
            start_date, 
            end_date, 
            rooms {
              room_id, 
              size,
              travellers
              {
                traveller_id, 
                first_name, 
                last_name
              }
            }
          }
        }
        dayplannings {
          date
          description
          location
          activities {
            name
            start_hour
            end_hour
          }
        }
        transports {
          driver_id
          travellers
          {
            traveller_id
            first_name
            last_name
          }
          size
        },
        emergencynumbers
        {
          number, 
          first_name, 
          last_name
        }
      }
    }
   """;
  return data;
}

