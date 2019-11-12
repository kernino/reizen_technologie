

class Car {
  final int id;
  final String size;

  Car({this.id, this.size});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size
    };
  }
}