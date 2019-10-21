
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Model/Database/database_helpers.dart';

DatabaseHelper db = new DatabaseHelper();

Future GetDayPlannings() async {
//  var dayPlanning1 = DayPlanning(
//      id: 1,
//      name: 'nameTest',
//      date: 'dateTest',
//      highlight: 'highlightTest',
//      description: 'descriptionTest');

  //db.insert(dayPlanning1);
  //List<DatabaseTable> planningList = await db.getAll(dayPlanning1);
  List<Map> result = await globals.database.query("day_planning", columns: ["name", "date", "highlight", "description"]);
  if(result != null) {
    print("data dayplanning ophalen gelukt: " + result[0].toString());
  }
  else{
    print("faaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaal");
  }

}