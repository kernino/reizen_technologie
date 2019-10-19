import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Room implements DatabaseTable {
  final int id;
  final String room_number;
  final String size;

  Room({this.id, this.room_number, this.size});

  @override
  int get field_id => this.id;

  @override
  String get table => "rooms";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_number': room_number,
      'size': size
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Room(
          id: maps[i]['id'],
          room_number: maps[i]['room_number'],
          size: maps[i]['size']
      );
    });
  }

  @override
  String toString() {
    return 'Room{id: $id, room: $room_number, size: $size}';
  }
}