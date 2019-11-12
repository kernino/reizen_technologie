class Activity {
  final int id;
  final int day_planning_id;
  final String start_hour;
  final String end_hour;
  final String description;
  final String location;
  final String name;

  Activity({this.id, this.day_planning_id, this.start_hour, this.end_hour, this.description, this.location, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day_planning_id': day_planning_id,
      'start_hour': start_hour,
      'end_hour': end_hour,
      'location': location,
      'description': description,
      'name': name
    };
  }
}