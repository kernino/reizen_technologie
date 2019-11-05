import 'package:flutter/material.dart';
import 'package:flutter_mobile_carousel/carousel.dart';
import 'package:flutter_mobile_carousel/carousel_arrow.dart';
import 'package:reizen_technologie/ViewModel/CarViewModel.dart';
import 'appbar.dart';

class CarsPage extends StatefulWidget {
  CarsPage({Key key, this.title}) :super(key: key);

  final String title;

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Cars"),
      body: new FutureBuilder(
          future: GetCars(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      var content;
      if (!snapshot.hasData) {
        if (snapshot.connectionState == ConnectionState.done) {
          content = [];
        }
        return CircularProgressIndicator();
      }
      content = snapshot.data;
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Autoverdeling',style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
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
            children: List.generate(content.length, (index){
              return Container(
                color: Color.fromRGBO(224,0,73,1.0),
                child: makeWidget(content[index]['car_number'],content[index]['size']),
                padding: EdgeInsets.all(5.0),
                margin: new EdgeInsets.all(10.0),
              );
            }).toList(),
          )
        ],
      );    }
    ),
    );
  }
}

Widget makeWidget(String carNumber, String size)
{
  List<Widget> widgets = new List<Widget>();
  widgets.add(Text("Chauffeur: "+carNumber,style: TextStyle(fontSize: 20.0, color: Colors.white)));
  widgets.add(Text(""));
  widgets.add(Text("Passagiers:", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)));
  for(int i=0; i<size.length; i++)
  {
    widgets.add(Text(size[i], style: TextStyle(color: Colors.white),));
  }
  return new Column(children: widgets,mainAxisAlignment: MainAxisAlignment.center,);
}