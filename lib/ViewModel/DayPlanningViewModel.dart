
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Model/Database/database_helpers.dart';
import 'package:reizen_technologie/main.dart';

DatabaseHelper db = new DatabaseHelper();

Future<List> GetAllData(int planningId) async {
  List<Map> allData = new List();
  List<Map> DayPlanning = await GetDayPlanningData(planningId);
  List<Map> DayPlannings = await GetDayPlannings();
  List<Map> Activities = await GetDayActivities();
  List<Map> ActivitiesByDay = await GetActivitiesByDay(planningId);

  allData.add({'day_planning': DayPlanning, 'day_plannings': DayPlannings, 'activities': Activities, 'activities_by_day': ActivitiesByDay });

  return allData;
}


Future<List> GetDayPlannings() async {
  List<Map> dayPlannings = await globals.database.query("days");
  if(dayPlannings != null) {
    print("data dayplanning ophalen gelukt: " + dayPlannings.toString());
  }
  else{
    print("error data dayplanning ophalen");
  }
return dayPlannings;
}

Future<List> GetDayPlanningData(int id) async {
List<Map> dayPlanningData = await globals.database.query('days', where: '"id" = ?', whereArgs: [id]);
if(dayPlanningData != null) {
  print("data day planning met id " + id.toString() + " ophalen gelukt: " + dayPlanningData.toString());
}
else{
  print("data day planning met id " + id.toString() + " ophalen NIET gelukt: ");
}
return dayPlanningData;
}

Future<List> GetDayActivities() async {
  List<Map> activities = await globals.database.query("plannings");
  if(activities != null) {
    print("data dayplannings ophalen gelukt: " + activities.toString());
  }
  else{
    print("error data dayplannings ophalen");
  }
  return activities;
}

Future<List> GetActivitiesByDay(int id) async {
  List<Map> activitiesData = await globals.database.query('plannings', where: '"day_id" = ?', whereArgs: [id]);
  if(activitiesData != []){
    print("activities met id " + id.toString() + " ophalen gelukt: " + activitiesData.toString());
  }
  else{
    print("data activities met id " + id.toString() + " ophalen NIET gelukt: ");
  }
  return activitiesData;
}