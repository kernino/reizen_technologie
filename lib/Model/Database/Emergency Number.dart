class EmergencyNumber {
  final int id;
  final int traveller_id;
  final String number;

  EmergencyNumber({this.id,this.traveller_id,this.number});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'traveller_id': traveller_id,
      'number': number
    };
  }
}