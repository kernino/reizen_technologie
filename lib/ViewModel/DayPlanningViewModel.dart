
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:reizen_technologie/main.dart';

DatabaseHelper db = new DatabaseHelper();

Future<List> GetDayPlannings() async {
  List<Map> dayPlannings = await globals.database.query("day_planning");
  if(dayPlannings != null) {
    print("data dayplanning ophalen gelukt: " + dayPlannings.toString());
  }
  else{
    print("error data dayplanning ophalen");
  }
return dayPlannings;
}

Future<List> GetDayPlanningData(int id) async {
List<Map> dayPlanningData = await globals.database.query('day_planning', where: '"id" = ?', whereArgs: [id]);
if(dayPlanningData != null) {
  print("data day planning met id " + id.toString() + " ophalen gelukt: " + dayPlanningData.toString());
}
else{
  print("data day planning met id " + id.toString() + " ophalen NIET gelukt: ");
}
return dayPlanningData;
}

Future<List> GetActivitiesByDay(int id) async {
  List<Map> activitiesData = await globals.database.query('activities', where: '"day_planning_id" = ?', whereArgs: [id]);
  if(activitiesData != null){
    print("activities met id " + id.toString() + "ophalen gelukt: " + activitiesData.toString());
  }
  else{
    print("data activities met id " + id.toString() + " ophalen NIET gelukt: ");
  }
  return activitiesData;
}