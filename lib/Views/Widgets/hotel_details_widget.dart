import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/hotels_widget.dart';
import 'appbar.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';

class HotelDetailsPage extends StatefulWidget {
  HotelDetailsPage({Key key, this.hotel}) : super(key: key);

  final int hotel;

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: GetHotelData(widget.hotel),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Container();
              case ConnectionState.active:
                return new Container();
              case ConnectionState.waiting:
                return new Container();
              case ConnectionState.done:
                var content = snapshot.data;
                return new Scaffold(
                  appBar: Appbar.getAppbar(
                    content[0]['name'],
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () =>
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelsPage()),
                            )),
                  ),
                  body: new Column(
                    children: <Widget>[
                      Text(content[0]['description']),
                    ],
                  ),
                );
            }
            return new Container();
          });


  }
}
