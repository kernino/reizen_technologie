import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Traveller_Trip implements DatabaseTable {
  final int id;
  final int trip_id;
  final int traveller_id;

  Traveller_Trip({this.id, this.trip_id, this.traveller_id});

  @override
  int get field_id => this.id;

  @override
  String get table => "traveller_trip";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trip_id': trip_id,
      'traveller_id': traveller_id
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Traveller_Trip(
          id: maps[i]['id'],
          trip_id: maps[i]['trip_id'],
          traveller_id: maps[i]['traveller_id']
      );
    });
  }

  @override
  String toString() {
    return 'TravellerTrip{id: $id, trip_id: $trip_id, traveller: $traveller_id}';
  }
}