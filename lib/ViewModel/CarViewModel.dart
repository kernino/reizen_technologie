import 'package:reizen_technologie/Model/globals.dart' as globals;


Future<List> GetCars() async {
  List<Map> cars = await globals.database.query("cars");
  if(cars != null) {
    print("data cars ophalen gelukt: " + cars.toString());
  }
  return cars;
}


Future<List> GetCarData(int id) async {;
List<Map> carData = await globals.database.query('cars', where: '"id" = ?', whereArgs: [id]);
if(carData != null) {
  print("data auto met id " + id.toString() + " ophalen gelukt: " + carData.toString());
}
else{
  print("data auto met id " + id.toString() + " ophalen NIET gelukt: ");
}
return carData;
}