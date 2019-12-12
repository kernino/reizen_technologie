class Planning {
  final int id;
  final String start_hour;
  final String end_hour;
  final String description;
  final String location;
  final String name;
  final int day_id;


  Planning({this.id, this.start_hour, this.end_hour, this.day_id, this.description, this.location, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_hour': start_hour,
      'end_hour': end_hour,
      'day_id': day_id,
      'location': location,
      'description': description,
      'name': name
    };
  }
}
