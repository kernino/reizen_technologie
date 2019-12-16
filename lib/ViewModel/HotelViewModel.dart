
import 'package:reizen_technologie/Model/globals.dart' as globals;


Future<List> GetHotels() async {
  List<Map> hotels = await globals.database.query("hotels");
  if(hotels != null) {
    print("data hotels ophalen gelukt: " + hotels.toString());
  }
return hotels;
}

Future<List> GetHotelData(int id) async {
  List<Map> hotel = await globals.database.query('hotels', where: '"id" = ?', whereArgs: [id]);
  List<Map> rooms = await globals.database.query('rooms',orderBy: "room_number ASC",where: '"hotel_id" = ?',whereArgs: [id]);
  List<Map> travellers = new List();
  if(rooms.isNotEmpty) {
    for (int i=0; i<rooms.length; i++) {
      int room_id = rooms[i]['id'];
      List<Map> travellersRoom = await globals.database.query(
          'room_traveller', where: '"room_id"=?', whereArgs: [room_id]);
      if(travellersRoom.isNotEmpty) {
        for (int a = 0; a < travellersRoom.length; a++) {
          List<Map> traveller = await globals.database.query(
              'travellers', where: '"id"=?',
              whereArgs: [travellersRoom[a]['traveller_id']]);
          travellers.add({
            'room': room_id,
            'traveller': traveller[0]['first_name'] + ' ' +
                traveller[0]['last_name']
          });
        }
      }
    }
  }
  List<Map> hotelData = new List();
  hotelData.add({'hotel':hotel[0], 'rooms':rooms, 'travellers':travellers});
  return hotelData;
}