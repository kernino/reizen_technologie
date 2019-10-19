
import 'package:reizen_technologie/Model/globals.dart' as globals;


Future GetDayPlannings() async {
  var dayPlannings ;
  List<Map> result = await globals.database.query("day_planning", columns: ["name", "date", "highlight", "description"]);
  if(result != null) {
    dayPlannings = result;
    print("data dayplanning ophalen gelukt: " + dayPlannings[0].toString());
  }

}