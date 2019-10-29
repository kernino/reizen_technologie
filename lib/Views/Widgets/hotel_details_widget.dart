import 'package:flutter/material.dart';
import 'package:reizen_technologie/Model/Database/Hotel.dart';
import 'appbar.dart';

class HotelDetails extends StatelessWidget {
  // Declare a field that holds the Hotel.
  final Hotel hotel;

  // In the constructor, require a Hotel.
  HotelDetails({Key key, @required this.hotel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hotelDetails',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //Color.fromRGBO(255, g, b, opacity),
        //Colors.red,
      ),
      home: HotelDetailsPage(hotel: this.hotel),
    );
  }
}

class HotelDetailsPage extends StatefulWidget {
  HotelDetailsPage({Key key, this.hotel}) : super(key: key);

  final Hotel hotel;

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar(widget.hotel.name),
      body: Text(widget.hotel.description)
    );
  }
}
