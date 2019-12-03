import 'package:reizen_technologie/Model/globals.dart' as globals;

Future<List> GetAllData() async {
  List<Map> allData = new List();
  List<Map> Users = await GetUser();
  allData.add({'user':Users[0],'day_planning':GetPlanning()});

  return allData;
}

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


Future<List> GetPlanning() async {
  List<Map> planningData = await globals.database.query('day_planning');
  if (planningData != null) {
    print("data day_planning ophalen gelukt: " + planningData.toString());
  }
  else {
    print("data day_planning ophalen NIET gelukt: ");
  }
  return planningData;
}
