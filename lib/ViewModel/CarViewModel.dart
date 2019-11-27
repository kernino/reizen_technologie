import 'package:reizen_technologie/Model/globals.dart' as globals;


Future<List> GetCars() async {
  List<Map> cars = await globals.database.query("cars");
  List<Map> data = new List();
  List<Map> travellers = await globals.database.query('travellers');
  if(cars != null){
  for(int i=0;i<cars.length;i++)
    {
      int counter = int.parse(cars[i]['id'].toString());
      List<Map> carTravellers = new List();
      for(int a=0; a<travellers.length; a++)
          {
            if(travellers[a]['car_id']==cars[i]['id']) {
              carTravellers.add({
                'naam': travellers[a]['first_name'] + ' ' +
                    travellers[a]['last_name']
              });
            }
          }
      if(carTravellers!=null) {
        List<Map> findDriver = await globals.database.query('travellers',where: '"id" =?',whereArgs: [cars[i]['driver_id']]);
        String chauffeur = findDriver[0]['first_name']+' '+findDriver[0]['last_name'];
        data.add({'reizigers': carTravellers,'chauffeur':chauffeur/*['first_name']+' '+travellers[cars[i]['driver_id']]['last_name']*/});
      }
    }
  }
  return data;
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