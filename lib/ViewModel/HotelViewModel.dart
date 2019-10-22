
import 'package:reizen_technologie/Model/globals.dart' as globals;


Future GetHotels() async {
  var hotels ;
  List<Map> result = await globals.database.query("hotels", columns: ["name", "description", "location", "photoUrl"]);
  if(result != null) {
    hotels = result;
    print("data hotels ophalen gelukt: " + hotels[0].toString());
  }

}