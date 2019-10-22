import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';

class Hotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hotels',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //Color.fromRGBO(255, g, b, opacity),
        //Colors.red,
      ),
      home: HotelsPage(title: 'Hotels'),
    );
  }
}

class HotelsPage extends StatefulWidget {
  HotelsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HotelsPageState createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Hotels"),
      body: //Image(image: new AssetImage('assets/hotels/hotel0.jpg'))
      GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(10, (index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 10, color: Colors.black38),
              borderRadius: const BorderRadius.all(const Radius.circular(8))
            ),
            margin: const EdgeInsets.all(4),
            child: /*new Column(

              children: <Widget>[*/
                new Image(image: new AssetImage('assets/hotels/hotel0.jpg'), fit: BoxFit.fill,)
//              ],
            ,
            //child: Image.asset('../Assets/Inlogscherm/ucll.png'),

          );
        }),
      ),
    );
  }
}
