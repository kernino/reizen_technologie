
import 'package:reizen_technologie/Model/globals.dart' as globals;


Future<List> GetHotels() async {
  List<Map> hotels = await globals.database.query("hotels");
  if(hotels != null) {
    print("data hotels ophalen gelukt: " + hotels.toString());
  }
return hotels;
}

Future<List> GetHotelData(int id) async {;
  List<Map> hotelData = await globals.database.query('hotels', where: '"id" = ?', whereArgs: [id]);
  if(hotelData != null) {
    print("data hotel met id " + id.toString() + " ophalen gelukt: " + hotelData.toString());
  }
  else{
    print("data hotel met id " + id.toString() + " ophalen NIET gelukt: ");
  }
  return hotelData;
}