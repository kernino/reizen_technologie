import 'package:reizen_technologie/Model/globals.dart' as globals;

Future<List> GetUser() async {
  List<Map> userData = await globals.database.query('users');
  if (userData != null) {
    print("data user ophalen gelukt: " + userData.toString());
  }
  else {
    print("data user ophalen NIET gelukt: ");
  }
  return userData;
}