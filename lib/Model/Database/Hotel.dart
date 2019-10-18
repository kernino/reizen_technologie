import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Hotel implements DatabaseTable {
  final int id;
  final String name;

  final String description;
  final String location;
  final String photoUrl;
  final int hotel_trip_id;
  final int hotel_room_id;

  Hotel({this.id, this.name, this.description, this.location, this.photoUrl, this.hotel_trip_id, this.hotel_room_id});

  @override
  int get field_id => this.id;

  @override
  String get table => "hotels";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'photoUrl': photoUrl,
      'hotel_trip_id': hotel_trip_id,
      'hotel_room_id': hotel_room_id
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Hotel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        location: maps[i]['location'],
        photoUrl: maps[i]['photoUrl'],
        hotel_trip_id: maps[i]['hotel_trip_id'],
        hotel_room_id: maps[i]['hotel_room_id']
      );
    });
  }

  @override
  String toString() {
    return 'Hotel{id: $id, name: $name, description: $description, '
        'location: $location, photo: $photoUrl, trip_id: $hotel_trip_id, roomid: $hotel_room_id}';
  }
}