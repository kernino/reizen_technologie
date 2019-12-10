import 'package:reizen_technologie/Model/globals.dart' as globals;

Future<List> GetInfo() async {
  List<Map> info = await globals.database.query("trip_info");
  if(info != null) {
    print("info ophalen gelukt: " + info.toString());
  }
  return info;
}