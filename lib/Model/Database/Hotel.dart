import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Hotel implements DatabaseTable {
  final int id;
  final String name;
  final String description;
  final String location;
  final String photoUrl;

  Hotel({this.id, this.name, this.description, this.location, this.photoUrl});

  @override
  int get field_id => this.id;

  @override
  String get table => "hotels";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'photoUrl': photoUrl,
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return Hotel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        location: maps[i]['location'],
        photoUrl: maps[i]['photoUrl'],
      );
    });
  }

  @override
  String toString() {
    return 'Hotel{id: $id, name: $name, description: $description, '
        'location: $location, photo: $photoUrl}';
  }
}