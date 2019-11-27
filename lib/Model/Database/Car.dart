

class Car {
  final int id;
  final String size;
  final int driver_id;

  Car({this.id, this.size,this.driver_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size,
      'driver_id':driver_id
    };
  }
}