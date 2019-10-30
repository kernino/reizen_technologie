import 'package:flutter/material.dart';
import 'appbar.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';

class HotelDetails extends StatelessWidget {
  // Declare a field that holds the Hotel.
  final int hotel;

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

  final int hotel;

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new FutureBuilder(
            future: GetHotelData(widget.hotel),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              var content = snapshot.data;
              return Scaffold(
                appBar: Appbar.getAppbar(content[0]['name']),
                body: Text(content[0]['description']),
              );
            }));
  }
}

//Text(widget.hotel.description)
