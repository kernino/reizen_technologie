import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Traveller_Room implements DatabaseTable {
  final int id;
  final int hotel_room_id;
  final int traveller_id;

  Traveller_Room({this.id, this.hotel_room_id, this.traveller_id});

  @override
  int get field_id => this.id;

  @override
  String get table => "traveller_room";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hotel_room_id': hotel_room_id,
      'traveller_id': traveller_id
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Traveller_Room(
          id: maps[i]['id'],
          hotel_room_id: maps[i]['hotel_room_id'],
          traveller_id: maps[i]['traveller_id']
      );
    });
  }

  @override
  String toString() {
    return 'TravellerTrip{id: $id, hotel_room: $hotel_room_id, traveller: $traveller_id}';
  }
}