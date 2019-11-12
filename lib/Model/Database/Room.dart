class Room  {
  final int id;
  final String room_number;
  final String size;
  final int hotel_id;

  Room({this.id, this.room_number, this.size, this.hotel_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_number': room_number,
      'size': size,
      'hotel_id': hotel_id
    };
  }
}