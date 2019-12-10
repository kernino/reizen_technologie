import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/hotels_widget.dart';
import 'appbar.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';

Widget makeWidget(LinkedHashMap list, int index, int max) {
  List<Widget> widgets = new List<Widget>();
  if (list['rooms'][index]['room_number'] == "null") {
    widgets.add(Text("Kamer ?", style: TextStyle(fontSize: 25.0)));
  } else {
    widgets.add(Text("Kamer " + list['rooms'][index]['room_number'].toString(),
        style: TextStyle(fontSize: 25.0)));
  }
  widgets.add(Text(""));
  int count = 0;
  for (int i = 0; i < list['travellers'].length; i++) {
    if (list['travellers'][i]['room'] == list['rooms'][index]['id']) {
      widgets.add(Text(list['travellers'][i]['traveller'],
          style: TextStyle(fontSize: 15.0)));
      count++;
    }
  }
  if (count < max) {
    for (int j = 0; j < (max - count); j++) {
      widgets.add(Text(""));
    }
  }
  return new Column(children: widgets);
}

int getMax(Map list) {
  int max = 0;
  for (int i = 0; i < list['rooms'].length; i++) {
    int count = 0;
    for (int j = 0; j < list['travellers'].length; j++) {
      if (list['travellers'][j]['room'] == list['rooms'][i]['id']) {
        count++;
      }
    }
    if (count > max) {
      max = count;
    }
  }
  return max;
}

final int index = 0;

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
            var content;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return Center(child: CircularProgressIndicator());
            }
            content = snapshot.data;
            var max = getMax(content[0]);
            return Scaffold(
              appBar: Appbar.getAppbar(
                content[0]['hotel']['name'],
                context,
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => HotelsPage()),
                    )),
              ),
              body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(content[0]['rooms'].length,
                              (index) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5, color: Colors.black26),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(20))),
                              child: makeWidget(content[0], index, max),
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(5.0),
                            );
                          }).toList(),
                        )),
                    Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        thickness: 3,
                      )),
                    ]),
                    Text(
                      'Info',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: new EdgeInsets.all(10.0),
                        child: Text(
                          content[0]['hotel']['description'],
                          //textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    new AspectRatio(
                      aspectRatio: 2 / 1,
                      child: Container(
                        padding: new EdgeInsets.all(10.0),
                        child: new Image.network(
                          content[0]['hotel']['photoUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ]),
            ),);
          }),
    );
  }
}

//Text(widget.hotel.description)
