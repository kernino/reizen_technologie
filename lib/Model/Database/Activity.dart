class Activity {
  final int id;
  final String description;
  final String location;
  final String name;

  Activity({this.id, this.description, this.location, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'description': description,
      'name': name
    };
  }
}