import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class EmergencyNumber implements DatabaseTable {
  final int id;
  final int user_id;
  final String number;

  EmergencyNumber({this.id,this.user_id,this.number});

  @override
  int get field_id => this.id;

  @override
  String get table => "emergency_numbers";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'number': number
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return EmergencyNumber(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        number: maps[i]['number']
      );
    });
  }

  @override
  String toString() {
    return 'EmergencyNumbers{id: $id, user: $user_id, number: $number}';
  }
}