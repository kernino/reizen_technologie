import 'dart:collection';

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
      appBar: Appbar.getAppbar("Auto"),
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
        return new Scrollbar(
          child: ListView(
              padding: EdgeInsets.all(10.0),
              children:
              List.generate(content.length, (index){
                     return
                       Container(
                        decoration: BoxDecoration(
                        border: Border.all(width: 10, color: Color.fromRGBO(224,0,73,1.0)),
                        borderRadius: const BorderRadius.all(const Radius.circular(8))
                      ),
                      child: makeWidget(content[index],index),
                      padding: EdgeInsets.all(5.0),
                         margin: EdgeInsets.all(5.0),

                    );
          }).toList(),
          )
      );    }
    ),
    );
  }
}

Widget makeWidget(LinkedHashMap map, int index)
{
  List<Widget> widgets = new List<Widget>();
  widgets.add(Text('Car '+index.toString(),style: TextStyle(fontWeight: FontWeight.bold, color:  Color.fromRGBO(224, 0, 73, 1.0),fontSize: 25)));
  widgets.add(Text(''));
  widgets.add(Text("Passagiers:", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(224,0,73,1.0),fontSize: 20)));
    for(int a=0;a<map['reizigers'].length;a++) {
      widgets.add(
          Text(map['reizigers'][a]['naam'], style: TextStyle(color: Color.fromRGBO(224,0,73,1.0),fontSize: 20)));
    }
  return Column(children: widgets,mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
}