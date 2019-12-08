import 'dart:collection';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobile_carousel/carousel.dart';
import 'package:flutter_mobile_carousel/carousel_arrow.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:reizen_technologie/ViewModel/VandaagViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

class Vandaag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (globals.connected == true) {}
    return FutureBuilder<void>(
        future: globals.dbHelper.Seed(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return MaterialApp(
            title: 'vandaag',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              //Color.fromRGBO(255, g, b, opacity),
            ),
            home: VandaagPage(title: 'Today'),
          );
        });
  }
}

class VandaagPage extends StatefulWidget {
  VandaagPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VandaagPageState createState() => _VandaagPageState();
}

class _VandaagPageState extends State<VandaagPage> {
  var _planningText =
      " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, mauris vitae pulvinar vulputate, enim diam pulvinar lacus, quis aliquet sapien nisi ut risus. Vestibulum interdum interdum velit. Morbi a dui tristique, convallis risus efficitur, pulvinar ex. Nam at augue eget massa rutrum congue. Nulla ultricies nisl at condimentum pulvinar. Nunc ut turpis a magna congue fringilla vel suscipit sem. Aenean eu tortor quis orci dignissim aliquet."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, mauris vitae pulvinar vulputate, enim diam pulvinar lacus, quis aliquet sapien nisi ut risus. Vestibulum interdum interdum velit. Morbi a dui tristique, convallis risus efficitur, pulvinar ex. Nam at augue eget massa rutrum congue. Nulla ultricies nisl at condimentum pulvinar. Nunc ut turpis a magna congue fringilla vel suscipit sem. Aenean eu tortor quis orci dignissim aliquet.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Vandaag", context),
      body: new FutureBuilder(
        future: GetAllData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var content;
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              content = [];
            }
            return Center(child: CircularProgressIndicator());
          }
          content = snapshot.data;
          //return Text(content.toString());
          return new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                _buildHeader(content),
                _buildCountDown(content),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  'Planning',
                  style: TextStyle(fontSize: 35),
                ),
                _buildExpandablePlanning(content),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  'Hotel',
                  style: TextStyle(fontSize: 35),
                ),
                _buildExpandableHotel(content),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                _buildExpandableAlgemeneInfo(content),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(var content) {
    return Row(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                new DateFormat.MMMMEEEEd('nl_BE')
                    .format(new DateTime.now())
                    .toUpperCase(),
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.left,
              ),
              Text(
                'Welkom ' + content[0]['user']['first_name'],
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ]),
      ),
    ]);
  }

  Widget _buildExpandablePlanning(var content) {
    if (content[0]['day_planning'] != null) {
      return Card(
        child: ExpandablePanel(
          header: Padding(
            padding: EdgeInsets.only(left: 4, right: 5, bottom: 5),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      content[0]['day_planning']['highlight'],
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      content[0]['day_planning']['location'],
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                )
              ],
            ),
          ),
          collapsed: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              content[0]['day_planning']['description'] + _planningText,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          expanded: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              content[0]['day_planning']['description'] + _planningText,
              softWrap: true,
            ),
          ),
          tapHeaderToExpand: true,
          hasIcon: true,
        ),
      );
    } else if (content[0]['day_planning'] == null) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 5, bottom: 20),
              child: Text(
                'Hier kan je binnenkort de dagplanning bekijken.',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildExpandableHotel(var content) {
    int hotelId = content[0]['hotel_id'] - 1;
    if (content[0]['hotel_data'].isNotEmpty) {
      return Card(
        //Randen foto laten overeenkomen met card:
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 1,
              child: new Image(
                image: new AssetImage(//content[index]['photoUrl']
                    'assets/hotels/hotel' + hotelId.toString() + '.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            ExpandablePanel(
              header: Padding(
                padding: EdgeInsets.only(left: 4, right: 5, bottom: 5, top: 8),
                child: Text(
                  content[0]['hotels'][hotelId]['name'],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              collapsed: null,
              expanded: _buildCarousel(content),
              tapHeaderToExpand: true,
              hasIcon: true,
            ),
          ],
        ),
      );
    } else if (content[0]['hotel_data'].isEmpty) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 5, bottom: 20),
              child: Text(
                'Hier kan je binnenkort iedere dag je hotel en je kamerindeling bekijken.',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildExpandableAlgemeneInfo(var content) {
    String algemeneInfo = content[0]['trip_info'][0]['info'];
    Widget algemeneInfoCol = Html(data: algemeneInfo,);
    Widget algemeneInfoExp = Html(data: algemeneInfo,);
    return ExpandablePanel(
      header: Padding(
        padding: EdgeInsets.only(left: 50),
        child: Text(
          'Algemene info',
          style: TextStyle(fontSize: 35),
          textAlign: TextAlign.center,
        ),
      ),
      collapsed: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: algemeneInfoCol,
        ),
      ),
      expanded: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: algemeneInfoExp
        ),
      ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }

  Widget _buildCountDown(var content) {
    dynamic counter = _countDays(content);

    if (counter > 0) {
      //Countertext opbouwen
      String days;
      var daysText;
      if (counter == 1) {
        days = ' dag!';
      } else if (counter > 1) {
        days = ' dagen!';
      }
      daysText = Text(
        'Nog ' + counter.toString() + days,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 5, bottom: 20),
                    child: daysText),
              ],
            ),
          )
        ],
      );
    } else if (counter <= 0) {
      return Padding(
        padding: EdgeInsets.all(0),
      );
    }
  }

  int _countDays(var content) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    //String todayString='2018-05-20'; //testData
    //var today = new DateFormat("yyyy-MM-dd").parse(todayString);//testdata
    String leaveDateString = content[0]['hotels'][0]['start_date'];
    var leaveDate = new DateFormat("yyyy-MM-dd").parse(leaveDateString);
    dynamic counter = leaveDate.difference(today).inDays;

    return counter;
  }

  Widget _buildCarousel(var content) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Color.fromRGBO(224, 0, 73, 1.0)),
          borderRadius: const BorderRadius.all(const Radius.circular(8)),
        ),
        child: //Text('kamertje'),
            makeRoomWidget(content),
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(5.0),
      ),
    );
  }

  Widget makeRoomWidget(var content) {
    List<Widget> widgets = new List<Widget>();

    //roomId van huidige traveller zoeken
    int travellerId = content[0]['user']['traveller_id'];
    int roomNumber;
    for (int i = 0; i < content[0]['hotel_data'][0]['travellers'].length; i++) {
      if (content[0]['hotel_data'][0]['travellers'][i]['traveller_id'] ==
          travellerId) {
        roomNumber = content[0]['hotel_data'][0]['travellers'][i]['room'];
      } else {
        roomNumber = 0;
      }
    }

    widgets.add(Text("Kamer " + (roomNumber + 1).toString(),
        style:
            TextStyle(fontSize: 30.0, color: Color.fromRGBO(224, 0, 73, 1.0))));
    widgets.add(Text(""));
    widgets.add(
      Text(
        "Leden:",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Color.fromRGBO(224, 0, 73, 1.0)),
      ),
    );

    //travellers zoeken die in de kamer zitten
    for (int i = 0; i < content[0]['hotel_data'][0]['travellers'].length; i++) {
      if (content[0]['hotel_data'][0]['travellers'][i]['room'] ==
          content[0]['hotel_data'][0]['rooms'][roomNumber]['id']) {
        widgets.add(
          Text(
            content[0]['hotel_data'][0]['travellers'][i]['traveller'],
            style: TextStyle(
                fontSize: 20.0, color: Color.fromRGBO(224, 0, 73, 1.0)),
          ),
        );
      }
    }
    return new Column(children: widgets);
  }
}
