import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:reizen_technologie/ViewModel/VandaagViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/algemene_info_widget.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;
import 'package:reizen_technologie/Views/Widgets/hotel_details_widget.dart';
import 'package:reizen_technologie/Views/Widgets/planning_details_widget.dart';

class VandaagPage extends StatefulWidget {
  VandaagPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VandaagPageState createState() => _VandaagPageState();
}

class _VandaagPageState extends State<VandaagPage> {
  var _planningText =
      " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, mauris vitae pulvinar vulputate, enim diam pulvinar lacus, quis aliquet sapien nisi ut risus. \nVestibulum interdum interdum velit. Morbi a dui tristique, convallis risus efficitur, pulvinar ex. \nNam at augue eget massa rutrum congue. Nulla ultricies nisl at condimentum pulvinar. Nunc ut turpis a magna congue fringilla vel suscipit sem. Aenean eu tortor quis orci dignissim aliquet."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, mauris vitae pulvinar vulputate, enim diam pulvinar lacus, quis aliquet sapien nisi ut risus. \nVestibulum interdum interdum velit. Morbi a dui tristique, convallis risus efficitur, pulvinar ex. Nam at augue eget massa rutrum congue. Nulla ultricies nisl at condimentum pulvinar. Nunc ut turpis a magna congue fringilla vel suscipit sem. Aenean eu tortor quis orci dignissim aliquet.";

  var now = DateTime.now();

  //var now = new DateFormat("yyyy-MM-dd").parse('2019-05-21'); //testdata

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
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Column(
                children: <Widget>[
                  _buildHeader(content),
                  _buildCountDown(content),
                  _buildPlanningHeader(content),
                  _buildExpandablePlanning(content),
                  _buildHotelHeader(content),
                  _buildExpandableHotel(content),
                  _buildAlgemeneInfoHeader(content),
                  _buildExpandableAlgemeneInfo(content),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(var content) {
    return Row(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 20.0, left: 5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                new DateFormat.MMMMEEEEd('nl_BE').format(now).toUpperCase(),
                style: TextStyle(fontSize: 14),
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
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      );

      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Card(
            elevation: 3,
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
    var today = DateTime(now.year, now.month, now.day);
    //String todayString='2018-05-20'; //testData
    //var today = new DateFormat("yyyy-MM-dd").parse(todayString);//testdata
    String leaveDateString = content[0]['hotels'][0]['start_date'];
    var leaveDate = new DateFormat("yyyy-MM-dd").parse(leaveDateString);
    dynamic counter = leaveDate.difference(today).inDays;

    return counter;
  }

  Widget _buildPlanningHeader(var content)
  {
    return Padding(
      padding:
      EdgeInsets.only(left: 3, right: 3, bottom: 7, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Planning',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w500),
          ),
          InkWell(
            child: Text(
              'Toon alles',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlanningDetailsPage(
                        dayPlanning: content[0]['day_planning']
                        ['id'])),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandablePlanning(var content) {
    if (content[0]['day_planning'] != null) {
      return Card(
        elevation: 3,
        child: ExpandablePanel(
          header: Padding(
            padding: EdgeInsets.only(left: 4, right: 5, bottom: 5, top: 5),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(content[0]['day_planning']['highlight'],
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 25)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      content[0]['day_planning']['location'],
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          collapsed: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              content[0]['day_planning']['description'],
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ),
          expanded: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              content[0]['day_planning']['description'],
              softWrap: true,
              textAlign: TextAlign.justify,
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

  Widget _buildHotelHeader(var content) {
    return Padding(
      padding:
      EdgeInsets.only(left: 3, right: 3, bottom: 7, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Hotel',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w500),
          ),
          InkWell(
            child: Text(
              'Toon alles',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HotelDetailsPage(
                        hotel: content[0]['hotels']
                        [content[0]['hotel_id'] - 1]['id'])),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableHotel(var content) {
    int hotelId = content[0]['hotel_id'] - 1;
    if (content[0]['hotel_data'].isNotEmpty) {
      return Card(
        elevation: 3,
        //Randen foto laten overeenkomen met card:
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 7 / 2,
              //uit lokale database:
              /*child: new Image(
                image: new AssetImage('assets/hotels/hotel' + hotelId.toString() + '.jpg'),

                fit: BoxFit.cover,
              ),*/
              //met photoUrl
              child: new Image.network(
                content[0]['hotels'][hotelId]['photoUrl'],
                fit: BoxFit.cover,
              ),
            ),
            ExpandablePanel(
              header: Padding(
                padding: EdgeInsets.only(left: 4, right: 5, bottom: 5, top: 5),
                child: Text(
                  content[0]['hotels'][hotelId]['name'],
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25),
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

  Widget _buildCarousel(var content) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.black26),
          borderRadius: const BorderRadius.all(const Radius.circular(20)),
        ),
        child: //Text('kamertje'),
            _makeRoomWidget(content),
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(5.0),
      ),
    );
  }

  Widget _makeRoomWidget(var content) {
    List<Widget> widgets = new List<Widget>();

    //roomId van huidige traveller zoeken
    int travellerId = content[0]['user']['traveller_id'];
    int roomId;
    for (int i = 0; i < content[0]['hotel_data'][0]['travellers'].length; i++) {
      if (content[0]['hotel_data'][0]['travellers'][i]['traveller_id'] ==
          travellerId) {
        roomId = content[0]['hotel_data'][0]['travellers'][i]['room'];
      }
    }
    for(int k=0; k<content[0]['hotel_data'][0]['rooms'].length;k++) {
      if(content[0]['hotel_data'][0]['rooms'][k]['id']==roomId)
        {
          if(content[0]['hotel_data'][0]['rooms'][k]['room_number']=="null")
            {
              widgets.add(Text("Kamer ?",
                  style:
                  TextStyle(fontSize: 30.0)));
            }
          else{
      widgets.add(Text("Kamer " + content[0]['hotel_data'][0]['rooms'][k]['room_number'].toString(),
          style:
          TextStyle(fontSize: 30.0)));
          }
        }
    }
    widgets.add(Text(""));
    widgets.add(
      Text(
        "Leden:",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0),
      ),
    );

    //travellers zoeken die in de kamer zitten
    for (int i = 0; i < content[0]['hotel_data'][0]['travellers'].length; i++) {
      if (content[0]['hotel_data'][0]['travellers'][i]['room'] == roomId) {
        widgets.add(
          Text(
            content[0]['hotel_data'][0]['travellers'][i]['traveller'],
            style: TextStyle(
                fontSize: 20.0),
          ),
        );
      }
    }
    return new Column(children: widgets);
  }

  Widget _buildAlgemeneInfoHeader(var content) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, bottom: 7, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            'Algemene info',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          InkWell(
            child: Text(
              'Toon alles',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AlgemeneInfoPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableAlgemeneInfo(var content) {
    String algemeneInfoString = content[0]['trip_info'][0]['info'];
    String delimiter = '</ul>';
    int lastIndex = algemeneInfoString.indexOf(delimiter);
    String algemeneInfoCut = algemeneInfoString.substring(0, lastIndex);
    Widget algemeneInfoHtml = Html(
      data: algemeneInfoCut,
    );
    return
        Padding(
          padding: EdgeInsets.only(bottom: 8), //nodig voor shadow onder card
          child: Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: algemeneInfoHtml,
            ),
          ),
        );
  }
}
