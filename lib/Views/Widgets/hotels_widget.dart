import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/hotel_details_widget.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';
import 'appbar.dart';

//void main() => runApp(Hotels());

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
        body: new FutureBuilder(
            future: GetHotels(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              var content;
              if (!snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  content = [];
                }
                return CircularProgressIndicator();
              }
              content = snapshot.data;
              //return Text(content.toString());
              return new GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(5.0),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(content.length, (index)
                /* 10 vervangen door aantal hotels */ {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HotelDetails(hotel: snapshot.data[index]['id'])),
                      );
                    },
                    child: Center(
                      child: new Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.grey),
                            borderRadius:
                            const BorderRadius.all(const Radius.circular(8))),

                        //enableFeedback: true,
                        child: new Column(children: <Widget>[
                          new AspectRatio(aspectRatio: 2/1,
                            child: new Image(
                              image: new AssetImage(
                                  'assets/hotels/hotel' + index.toString() + '.jpg'),
                              fit: BoxFit.cover,
                            ),),

                          new Stack(
                            children: <Widget>[
/*                      Container(
                        color: Colors.redAccent,
                      ),*/
                              new Center(
                                child: new Column(children: <Widget>[
                                  FittedBox(fit:BoxFit.fitWidth, child:
                                  Text(content[index]['name'],
                                      style: TextStyle(
                                          fontSize: 24, fontWeight: FontWeight.bold))),
                                  Text(content[index]['location'],
                                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                                  ),
                                  Text("\n" + "Day: 1-2",
                                      style: TextStyle(fontSize: 18)),
                                ]),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                }),
              );
            }));
  }
}


//oude widget zonder futurebuilder
/*Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Hotels"),
      body:
      GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(5.0),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(4, (index)
            /* 10 vervangen door aantal hotels */ {
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HotelDetails(hotel: hotel1)),
              );
            },
            child: Center(
              child: new Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.grey),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(8))),

                //enableFeedback: true,
                child: new Column(children: <Widget>[
                  new AspectRatio(aspectRatio: 2/1,
                    child: new Image(
                    image: new AssetImage(
                        'assets/hotels/hotel' + index.toString() + '.jpg'),
                    fit: BoxFit.cover,
                  ),),

                  new Stack(
                    children: <Widget>[
/*                      Container(
                        color: Colors.redAccent,
                      ),*/
                      new Center(
                        child: new Column(children: <Widget>[
                        FittedBox(fit:BoxFit.fitWidth, child:
                          Text("Hotel " + index.toString(),
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))),
                          Text(hotels[0].toString(),
                              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                          Text("\n" + "Day: 1-2",
                              style: TextStyle(fontSize: 18)),
                        ]),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}*/
