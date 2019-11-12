class Hotel {
  final int id;
  final String name;
  final String description;
  final String location;
  final String photoUrl;
  final String start_date;
  final String end_date;

  Hotel({this.id, this.name, this.description, this.location, this.photoUrl, this.start_date, this.end_date});

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
}