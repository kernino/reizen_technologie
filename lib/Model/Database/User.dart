import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class User implements DatabaseTable {
  final int id;
  final String firstName;
  final String lastName;
  final int acceptedConditions;
  final String token;
  final int traveller_id;

  User({this.id, this.firstName, this.lastName, this.acceptedConditions, this.token, this.traveller_id});

  @override
  int get field_id => this.id;

  @override
  String get table => "users";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'accepted_conditions': acceptedConditions,
      'token': token,
      'traveller_id': traveller_id
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User(
          id: maps[i]['id'],
          firstName: maps[i]['first_name'],
          lastName: maps[i]['last_name'],
          acceptedConditions: maps[i]['accepted_conditions'],
          token: maps[i]['token'],
          traveller_id: maps[i]['traveller_id']
      );
    });
  }

  @override
  String toString() {
    return 'User{id: $id, first_name: $firstName, last_name: $lastName, accepted_conditions: $acceptedConditions, token: $token, traveller: $traveller_id}';
  }
}