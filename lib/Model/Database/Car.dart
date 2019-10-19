import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Car implements DatabaseTable {
  final int id;
  final String car_number;
  final String size;

  Car({this.id, this.car_number, this.size});

  @override
  int get field_id => this.id;

  @override
  String get table => "cars";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car_number': car_number,
      'size': size
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Car(
          id: maps[i]['id'],
          car_number: maps[i]['car_number'],
          size: maps[i]['size']
      );
    });
  }

  @override
  String toString() {
    return 'Car{id: $id, car: $car_number, size: $size}';
  }
}