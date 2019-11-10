import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reizen_technologie/Views/Widgets/cars_widget.dart';
import 'package:reizen_technologie/Views/Widgets/hotels_widget.dart';
import 'package:reizen_technologie/Views/Widgets/planning_widget.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';

class Navbar extends StatefulWidget {
  Navbar({Key key}) : super(key: key);

  @override
  NavbarState createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  int selectedIndex = 0;
  final widgetOptions = [
    new Vandaag(),
    new PlanningPage(),
    new CarsPage(),
    new HotelsPage(),
    Text('Contacten page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Color.fromRGBO(224, 0, 73, 1.0) ,
        type: BottomNavigationBarType.fixed ,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('vandaag', style: TextStyle(color: Colors.white),),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('planning', style: TextStyle(color: Colors.white),),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.directions_car,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('auto', style: TextStyle(color: Colors.white),),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.hotel,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('hotel', style: TextStyle(color: Colors.white),),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.group,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('contacten', style: TextStyle(color: Colors.white),),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedFontSize: 15,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}