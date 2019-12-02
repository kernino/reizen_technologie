class EmergencyNumber {
  final int id;
  final String first_name;
  final String last_name;
  final String number;

  EmergencyNumber({this.id,this.first_name,this.last_name,this.number});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'number': number
    };
  }
}