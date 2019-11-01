import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    new Planning(),
    Text('AutoPage'),
    new Hotels(),
    Text('Contacten page'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: Color.fromRGBO(212, 0, 69, 1.0) ,
        type: BottomNavigationBarType.fixed ,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('calender'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.directions_car,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('auto'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.hotel,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('hotel'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.group,color: Color.fromRGBO(255, 255, 255, 1.0)),
            title: new Text('contacten'),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}