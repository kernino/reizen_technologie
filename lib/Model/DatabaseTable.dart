

abstract class DatabaseTable {

  String get table;

  int get field_id;

  Future<List<DatabaseTable>> getAll(List<Map<String, dynamic>> maps);

  Map<String, dynamic> toMap();

  String toString();
}