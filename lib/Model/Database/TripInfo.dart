class TripInfo {
  final int id;
  final String info;


  TripInfo({this.id, this.info});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'info': info,
    };
  }
}