import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Model/Database/database_helpers.dart';

DatabaseHelper db = new DatabaseHelper();

Future<List> GetTravellers() async {
  List<Map> travellers = await globals.database.query("travellers");
  if(travellers != null) {
    print("data travellers ophalen gelukt: " + travellers.toString());
  }
  else{
    print("error data travellers ophalen");
  }
  return travellers;
}

Future<List> GetTravellerById(int id) async {
List<Map> traveller = await globals.database.query('travellers', where: '"id" = ?', whereArgs: [id]);
if(traveller != null) {
  print("data traveller met id " + id.toString() + " ophalen gelukt: " + traveller.toString());
}
else{
  print("data traveller met id " + id.toString() + " ophalen NIET gelukt: ");
}
return traveller;
}