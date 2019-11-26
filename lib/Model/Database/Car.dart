

class Car {
  final int id;
  final driver_id;
  final String size;

  Car({this.id, this.size, this.driver_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size,
      'driver_id': driver_id
    };
  }
}