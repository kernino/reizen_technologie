import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Database/DatabaseTable.dart';

class DayPlanning implements DatabaseTable {
  final int id;
  final String name;
  final String date;
  final String highlight;
  final String description;
  final String end_location;

  DayPlanning({this.id, this.name, this.date, this.highlight, this.description, this.end_location});

  @override
  int get field_id => this.id;

  @override
  String get table => "day_planning";

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'highlight': highlight,
      'description': description,
      'end_location': end_location
    };
  }

  @override
  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps) async {

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return DayPlanning(
        id: maps[i]['id'],
        name: maps[i]['name'],
        date: maps[i]['date'],
        highlight: maps[i]['highlight'],
        description: maps[i]['description'],
        end_location: maps[i]['end_location']
      );
    });
  }

  @override
  String toString() {
    return 'DayPlanning{id: $id, name: $name, description: $description, '
        'date: $date, highlight: $highlight, location: $end_location}';
  }
}