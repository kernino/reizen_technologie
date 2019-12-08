import 'package:intl/intl.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

Future<List> GetAllData() async {

  //var now = DateTime.now();
  //var today = DateTime(now.year, now.month, now.day);
  String todayString='2020-5-22'; //testData
  var today = new DateFormat("yyyy-MM-dd").parse(todayString);//testdata

  List<Map> allData = new List();
  List<Map> Users = await GetUser();
  List<Map> Plannings = await GetDayPlannings();

  dynamic _findDayPlanning(){
    for(int i = 0; i<Plannings.length; i++)
      {
        String planningDateString = Plannings[i]['date'];
        var planningDate = new DateFormat("yyyy-MM-dd").parse(planningDateString);
        if(planningDate == today)
        {
          return Plannings[i];
        }
      }
    return -1;
  }
  var dayPlanning = _findDayPlanning();
  var Planning;
  if (dayPlanning != -1)
  {
    Planning = dayPlanning;
  }
  else if (dayPlanning == -1)
  {
    Planning = null;
  }

  List<Map> Hotels = await GetHotels();
  List<Map> HotelData;

  int _findHotelId(){
    for(int i = 0; i<Hotels.length; i++)
      {
        String hotelStartDateString = Hotels[i]['start_date'];
        String hotelEndDateString = Hotels[i]['end_date'];
        var hotelStartDate = new DateFormat("yyyy-MM-dd").parse(hotelStartDateString);
        var hotelEndDate = new DateFormat("yyyy-MM-dd").parse(hotelEndDateString);
        if((hotelStartDate == today || hotelStartDate.isBefore(today)) && hotelEndDate.isAfter(today))
        {
          return  Hotels[i]['id'];
        }
      }
    return -1;
  }
  int hotelId = _findHotelId();
  if(hotelId != -1)
    {
      HotelData = await GetHotelData(hotelId);
    }
  else if (hotelId == -1)
    {
      HotelData = new List<Map>();
    }

  List<Map> Info = await GetInfo();
  List<Map> Trips = await GetTrips();

  allData.add({'user':Users[0],'day_planning': Planning, 'hotels': Hotels, 'hotel_data': HotelData, 'trip_info': Info, 'trips': Trips, 'hotel_id': hotelId});

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

Future<List> GetHotels() async {
  List<Map> hotels = await globals.database.query("hotels");
  if(hotels != null) {
    print("data hotels ophalen gelukt: " + hotels.toString());
  }
  return hotels;
}

Future<List> GetHotelData(int id) async {
  List<Map> hotel = await globals.database.query('hotels', where: '"id" = ?', whereArgs: [id]);
  List<Map> rooms = await globals.database.query('rooms',where: '"hotel_id" = ?',whereArgs: [id]);
  List<Map> travellers = new List();
  if(rooms.isNotEmpty) {
    for (int i=0; i<rooms.length; i++) {
      int room_id = rooms[i]['id'];
      List<Map> travellersRoom = await globals.database.query(
          'room_traveller', where: '"room_id"=?', whereArgs: [room_id]);
      if(travellersRoom.isNotEmpty) {
        for (int a = 0; a < travellersRoom.length; a++) {
          List<Map> traveller = await globals.database.query(
              'travellers', where: '"id"=?',
              whereArgs: [travellersRoom[a]['traveller_id']]);
          travellers.add({
            'room': room_id,
            'traveller': traveller[0]['first_name'] + ' ' +
                traveller[0]['last_name'],
            'traveller_id': traveller[0]['id']
          });
        }
      }
    }
  }
  List<Map> hotelData = new List();
  hotelData.add({'hotel':hotel[0], 'rooms':rooms, 'travellers':travellers});
  return hotelData;
}

Future<List> GetInfo() async {
  List<Map> info = await globals.database.query("trip_info");
  if(info != null) {
    print("info ophalen gelukt: " + info.toString());
  }
  return info;
}

Future<List> GetTrips() async {
  List<Map> trips = await globals.database.query("trips");
  if(trips != null) {
    print("info ophalen gelukt: " + trips.toString());
  }
  return trips;
}