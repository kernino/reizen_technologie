import 'package:flutter/cupertino.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class Hotel implements DatabaseTable {
  final int id;
  final String name;
  final String description;
  final String location;
  final String photoUrl;
  final String start_date;
  final String end_date;

  Hotel({this.id, this.name, this.description, this.location, this.photoUrl, this.start_date, this.end_date});

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
      'start_date': start_date,
      'end_date': end_date
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
        start_date: maps[i]['start_date'],
        end_date: maps[i]['end_date']
      );
    });
  }

  @override
  String toString() {
    return 'Hotel{id: $id, name: $name, description: $description, '
        'location: $location, photo: $photoUrl, start: $start_date, end $end_date}';
  }
}