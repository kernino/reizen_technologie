import 'dart:collection';

import 'package:flutter/material.dart';
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
      appBar: Appbar.getAppbar("Auto", context),
      body: new FutureBuilder(
          future: GetCars(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        var content;
        if (!snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            content = [];
          }
        return Center(child: CircularProgressIndicator());
        }
        content = snapshot.data;
        return new Scrollbar(
          child: ListView(
              padding: EdgeInsets.all(5.0),
              children:
              List.generate(content.length, (index){
                     return
                       Container(
                        decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.black26),
                        borderRadius: const BorderRadius.all(const Radius.circular(20))
                      ),
                      child: makeWidget(content[index],index),
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(top:5.0,bottom: 5.0,left:20.0,right: 20.0)

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
  widgets.add(Icon(Icons.directions_car,color: Color.fromRGBO(224, 0, 73, 1.0),size: 50));
  widgets.add(Text(""));
  widgets.add(Text('Chauffeur:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)));
  widgets.add(Text(map['chauffeur'], style: TextStyle(fontSize: 15.0),));
  widgets.add(Text("",style: TextStyle(fontSize: 5.0)));
  widgets.add(Text("Passagiers:", style: TextStyle(fontWeight: FontWeight.bold,fontSize:20)));
    for(int a=0;a<map['reizigers'].length;a++) {
      widgets.add(Text(map['reizigers'][a]['naam'],style: TextStyle(fontSize: 15.0),));
    }
  return Column(children: widgets,mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
}