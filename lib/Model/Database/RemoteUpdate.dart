class RemoteUpdate {
  final int id;
  final String update_time;

  RemoteUpdate({this.id, this.update_time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'update_time': update_time
    };
  }
}