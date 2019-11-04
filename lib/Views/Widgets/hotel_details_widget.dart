import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/hotels_widget.dart';
import 'appbar.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';
import 'package:flutter_mobile_carousel/carousel.dart';
import 'package:flutter_mobile_carousel/carousel_arrow.dart';
import 'package:flutter_mobile_carousel/default_carousel_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<List<String>> Dump = [['1','Kevin','Shrek', 'Chris P. Chicken', 'Dixon Kuntz'],['2','Richard Batsbak','Gerrie Van Boven', 'Rikkert Biemans', 'Robbie Schuurmans', 'Barrie Butsers'],['3','Student 1','Student 2']];

Widget makeWidget(List<String> list)
{
  List<Widget> widgets = new List<Widget>();
  widgets.add(Text("Kamer: "+list[0],style: TextStyle(fontSize: 30.0, color:Colors.white),));
  widgets.add(Text(""));
  widgets.add(Text("Leden:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color:Colors.white)));
  for(int i=1; i<list.length; i++)
  {
    widgets.add(Text(list[i], style: TextStyle(fontSize: 18.0, color:Colors.white)));
  }
  return new Column(children: widgets);
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
  List<List<String>> Dump = [['1','Kevin','Shrek', 'Chris P. Chicken', 'Dixon Kuntz'],['2','Richard Batsbak','Gerrie Van Boven', 'Rikkert Biemans', 'Robbie Schuurmans', 'Barrie Butsers'],['3','Student 1','Student 2']];
  List<List<String>> Dump2 = [['1','Koen','Kevin', 'Stijn', 'Nino'],['2','Zeno','Christian', 'Daan'],['3','Pieter','Sibert']];
  List<List<String>> Dump3 = [['1','Mario','Luigi'],['2','Crimson Chin','Crash Nebula', 'Catman', 'Bronze Knee Cap'],['3','Student 1','Student 2']];


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
                  body: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Carousel(
                              rightArrow: CarouselArrow(
                                width: 30.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                      Icons.chevron_right,
                                      size: 15.0
                                  ),
                                ),
                              ),
                              leftArrow: CarouselArrow(
                                width: 30.0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                      Icons.chevron_left,
                                      size: 15.0
                                  ),
                                ),
                              ),
                              rowCount: 1,
                              children: Dump.map((List<String> itext){
                                return Container(
                                  color: Color.fromRGBO(224,0,73,1.0),
                                  child: makeWidget(itext),
                                  padding: EdgeInsets.all(5.0),
                                  margin: new EdgeInsets.all(10.0),
                                );
                              }).toList(),
                            ),

                            Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Divider(
                                        thickness: 3,
                                      )
                                  ),
                                ]
                            ),
                            Text(
                              'Info',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 25.0),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: new EdgeInsets.all(10.0),
                                child:
                                Text(
                                  content[0]['description'],
                                  //textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ),

                            new AspectRatio(aspectRatio: 2/1,
                              child: Container(
                                padding: new EdgeInsets.all(10.0),
                                child: new Image(
                                  image: new AssetImage(
                                      'assets/hotels/hotel' + (widget.hotel - 1).toString() + '.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )

                          ]

                      )
                  )
              );
            }));
  }
}

//Text(widget.hotel.description)
