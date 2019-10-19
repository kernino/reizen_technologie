import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Traveller implements DatabaseTable {
  final int id;
  final String first_name;
  final String last_name;
  final String major_name;
  final String phone;
  final int room_id;
  final int car_id;

  Traveller({this.id, this.first_name, this.last_name, this.major_name, this.phone, this.room_id, this.car_id});

  @override
  int get field_id => this.id;

  @override
  String get table => "travellers";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'major_name': major_name,
      'phone': phone,
      'room_id': room_id,
      'car_id': car_id
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Traveller(
          id: maps[i]['id'],
          first_name: maps[i]['first_name'],
          last_name: maps[i]['last_name'],
          major_name: maps[i]['major_name'],
          phone: maps[i]['phone'],
          room_id: maps[i]['room_id'],
          car_id: maps[i]['car_id']
      );
    });
  }

  @override
  String toString() {
    return 'Traveller{id: $id, first_name: $first_name, last_name: $last_name, '
           'major: $major_name, phone: $phone, room: $room_id, car: $car_id}';
  }
}