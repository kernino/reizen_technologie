import 'package:reizen_technologie/Model/globals.dart' as globals;


Future GetCars() async {
  var cars ;
  List<Map> result = await globals.database.query("cars", columns: ["car_number", "size"]);
  if(result != null) {
    cars = result;
    print("data cars ophalen gelukt: " + cars[0].toString());
  }

}