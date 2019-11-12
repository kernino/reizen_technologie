class DayPlanning {
  final int id;
  final String date;
  final String highlight;
  final String description;
  final String location;

  DayPlanning({this.id, this.date, this.highlight, this.description, this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'highlight': highlight,
      'description': description,
      'location': location
    };
  }
}