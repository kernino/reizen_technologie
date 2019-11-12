class Trip {
  final int id;
  final String name;
  final String start_date;
  final String end_date;
  final String destination;
  final String transportation_info;

  Trip({this.id, this.name, this.start_date, this.end_date, this.destination, this.transportation_info});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start_date': start_date,
      'end_date': end_date,
      'destination': destination,
      'transport_info': transportation_info
    };
  }
}