
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Model/Database/database_helpers.dart';

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