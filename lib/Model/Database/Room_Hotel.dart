import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Room_Hotel implements DatabaseTable {
  final int id;
  final int hotel_trip_id;
  final String room_number;
  final String size;

  Room_Hotel({this.id, this.hotel_trip_id, this.room_number, this.size});

  @override
  int get field_id => this.id;

  @override
  String get table => "room_hotel";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hotel_trip_id': hotel_trip_id,
      'room_number': room_number,
      'size': size
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Room_Hotel(
          id: maps[i]['id'],
          hotel_trip_id: maps[i]['hotel_trip_id'],
          room_number: maps[i]['room_number'],
          size: maps[i]['size']
      );
    });
  }

  @override
  String toString() {
    return 'RoomHotel{id: $id, hotel_trip_id: $hotel_trip_id, room: $room_number, size: $size}';
  }
}