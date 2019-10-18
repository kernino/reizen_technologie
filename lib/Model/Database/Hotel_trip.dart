import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Hotel_Trip implements DatabaseTable {
  final int id;
  final int trip_id;
  final int hotel_id;
  final String start_date;
  final String end_date;

  Hotel_Trip({this.id, this.trip_id, this.hotel_id, this.start_date, this.end_date});

  @override
  int get field_id => this.id;

  @override
  String get table => "hotel_trip";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trip_id': trip_id,
      'hotel_id': hotel_id,
      'start_date': start_date,
      'end_date': end_date
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Hotel_Trip(
          id: maps[i]['id'],
          trip_id: maps[i]['trip_id'],
          hotel_id: maps[i]['hotel_id'],
          start_date: maps[i]['start_date'],
          end_date: maps[i]['end_date']
      );
    });
  }

  @override
  String toString() {
    return 'HotelTrip{id: $id, trip_id: $trip_id, hotel: $hotel_id, start: $start_date, end: $end_date}';
  }
}