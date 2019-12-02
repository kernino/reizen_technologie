import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/hotels_widget.dart';
import 'appbar.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';
import 'package:flutter_mobile_carousel/carousel.dart';
import 'package:flutter_mobile_carousel/carousel_arrow.dart';

Widget makeWidget(LinkedHashMap list, int index)
{
  List<Widget> widgets = new List<Widget>();
  widgets.add(Text("Kamer "+(index+1).toString(),style: TextStyle(fontSize: 30.0, color:Color.fromRGBO(224,0,73,1.0))));
  widgets.add(Text(""));
  for(int i=0;i<list['travellers'].length;i++)
    {
      if(list['travellers'][i]['room']==list['rooms'][index]['id'])
        {
          widgets.add(Text(list['travellers'][i]['traveller'], style: TextStyle(fontSize: 20.0, color:Color.fromRGBO(224,0,73,1.0))));
        }
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

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar.getAppbar(
          "Details",
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => HotelsPage()),
              )),
        ),
        body: new FutureBuilder(
            future: GetHotelData(widget.hotel),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              var content = snapshot.data;
              if (!snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  content = [];
                }
                return Center(child: CircularProgressIndicator());
              }
                  return SingleChildScrollView(
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

                              children: List.generate(content[0]['rooms'].length, (index){
                                return
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 5, color: Color.fromRGBO(224,0,73,1.0)),
                                        borderRadius: const BorderRadius.all(const Radius.circular(8))
                                    ),
                                    child: makeWidget(content[0],index),
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(5.0),

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
                                  content[0]['hotel']['description'],
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
              ;
            }));
  }
}

//Text(widget.hotel.description)
