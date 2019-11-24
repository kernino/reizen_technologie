import 'package:reizen_technologie/Model/globals.dart' as globals;


Future<List> GetTripInfo() async {
  List<Map> tripInfo = await globals.database.query("trip_info");
  if(tripInfo != null) {
    print("data trip_info ophalen gelukt: " + tripInfo.toString());
  }
  return tripInfo;
}

