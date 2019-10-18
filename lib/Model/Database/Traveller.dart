import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Hotel implements DatabaseTable {
  final int id;
  final String first_name;
  final String last_name;
  final String major_name;
  final String email;
  final String country;
  final String address;
  final String gender;
  final String phone;
  final String birthdate;

  Hotel({this.id, this.first_name, this.last_name, this.major_name, this.email, this.country, this.address, this.gender, this.phone, this.birthdate});

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
      'email': email,
      'country': country,
      'address': address,
      'gender': gender,
      'phone': phone,
      'birthdate': birthdate
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Hotel(
          id: maps[i]['id'],
          first_name: maps[i]['first_name'],
          last_name: maps[i]['last_name'],
          major_name: maps[i]['major_name'],
          email: maps[i]['email'],
          country: maps[i]['country'],
          address: maps[i]['address'],
          gender: maps[i]['gender'],
          phone: maps[i]['phone'],
          birthdate: maps[i]['birthdate']
      );
    });
  }

  @override
  String toString() {
    return 'Hotel{id: $id, first_name: $first_name, last_name: $last_name, major: $major_name, '
        'email: $email, country: $country, address: $address, '
        'gender: $gender, phone: $phone, birthdate: $birthdate}';
  }
}