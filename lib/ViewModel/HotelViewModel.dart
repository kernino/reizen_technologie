
import 'package:reizen_technologie/Model/globals.dart' as globals;


Future<List> GetHotels() async {
  var hotels ;
  List<Map> result = await globals.database.query("hotels");
  if(result != null) {
    hotels = result;
    print("data hotels ophalen gelukt: " + hotels.toString());
  }
return hotels;
}

Future<List> GetHotelData(int id) async {
  var hotelData ;
  List<Map> result = await globals.database.query('hotels', where: '"id" = ?', whereArgs: [id]);
  if(result != null) {
    hotelData = result;
    print("data hotel met id " + id.toString() + " ophalen gelukt: " + hotelData.toString());
  }
  else{
    print("data hotel met id " + id.toString() + " ophalen NIET gelukt: ");
  }
  return hotelData;
}