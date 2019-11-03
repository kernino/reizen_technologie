import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/hotel_details_widget.dart';
import 'package:reizen_technologie/ViewModel/HotelViewModel.dart';
import 'appbar.dart';

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
            padding: EdgeInsets.all(10.0),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(content.length, (index) {
              var stringStart = content[index]['start_date'];
              stringStart = stringStart.split("-");
              var stringEnd = content[index]['end_date'];
              stringEnd = stringEnd.split("-");

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HotelDetailsPage(
                            hotel: snapshot.data[index]['id'])),
                  );
                },
                child: Center(
                  child: new Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.black26),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8))),

                    //enableFeedback: true,
                    child: new Column(children: <Widget>[
                      new AspectRatio(
                        aspectRatio: 2 / 1,
                        child: new Image(
                          image: new AssetImage(content[index]['photoUrl']
                              /*'assets/hotels/hotel' +
                              index.toString() +
                              '.jpg'*/
                              ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      new Center(
                        child: new Column(children: <Widget>[
                          Padding(padding: EdgeInsets.all(5.0)), //beetje ruimte boven titel
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(content[index]['name'],
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold))),
                          Text(
                            content[index]['location'],
                            style: TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                          RichText(
                            text: TextSpan(
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              children: <TextSpan>[
                                //TextSpan(text: DateTime.now().toString())
                                //TextSpan(text: '\n'),
                                TextSpan(
                                    text:
                                        stringStart[1] + "/" + stringStart[2]),
                                TextSpan(text: ' tot '),
                                TextSpan(
                                    text: stringEnd[1] + "/" + stringEnd[2]),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ]),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
