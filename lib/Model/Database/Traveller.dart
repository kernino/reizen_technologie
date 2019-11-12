class Traveller {
  final int id;
  final String first_name;
  final String last_name;
  final String major_name;
  final String phone;
  final int driver;
  final int car_id;

  Traveller({this.id, this.first_name, this.last_name, this.major_name, this.phone, this.driver, this.car_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'major_name': major_name,
      'phone': phone,
      'driver': driver,
      'car_id': car_id
    };
  }
}