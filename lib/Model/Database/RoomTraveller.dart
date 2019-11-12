class RoomTraveller  {
  final int id;
  final int room_id;
  final int traveller_id;

  RoomTraveller({this.id, this.room_id, this.traveller_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': room_id,
      'traveller_id': traveller_id
    };
  }
}