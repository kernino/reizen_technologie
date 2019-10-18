import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Trip implements DatabaseTable {
  final int id;
  final String name;
  final int is_active;
  final String year;
  final double price;
  final String start_date;
  final String end_date;
  final String destination;
  final String transportation_info;

  Trip({this.id, this.name, this.is_active, this.year, this.price, this.start_date, this.end_date, this.destination, this.transportation_info});

  @override
  int get field_id => this.id;

  @override
  String get table => "trips";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_active': is_active,
      'year': year,
      'price': price,
      'start_date': start_date,
      'end_date': end_date,
      'destination': destination,
      'transport_info': transportation_info
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Trip(
          id: maps[i]['id'],
          name: maps[i]['name'],
          is_active: maps[i]['is_active'],
          year: maps[i]['year'],
          price: maps[i]['price'],
          start_date: maps[i]['start_date'],
          end_date: maps[i]['end_date'],
          destination: maps[i]['destination'],
          transportation_info: maps[i]['transportation_info']
      );
    });
  }

  @override
  String toString() {
    return 'Trip{id: $id, name: $name, is_active: $is_active, year: $year, '
        'price: $price, start_date: $start_date, end_date: $end_date, '
        'destination: $destination, transport: $transportation_info}';
  }
}