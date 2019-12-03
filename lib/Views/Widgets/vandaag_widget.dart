import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
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
  //the countdown
  dynamic f_counter = DateTime(2020, 5, 17).difference(DateTime.now()).inDays;
  var _planningText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, mauris vitae pulvinar vulputate, enim diam pulvinar lacus, quis aliquet sapien nisi ut risus. Vestibulum interdum interdum velit. Morbi a dui tristique, convallis risus efficitur, pulvinar ex. Nam at augue eget massa rutrum congue. Nulla ultricies nisl at condimentum pulvinar. Nunc ut turpis a magna congue fringilla vel suscipit sem. Aenean eu tortor quis orci dignissim aliquet."
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, mauris vitae pulvinar vulputate, enim diam pulvinar lacus, quis aliquet sapien nisi ut risus. Vestibulum interdum interdum velit. Morbi a dui tristique, convallis risus efficitur, pulvinar ex. Nam at augue eget massa rutrum congue. Nulla ultricies nisl at condimentum pulvinar. Nunc ut turpis a magna congue fringilla vel suscipit sem. Aenean eu tortor quis orci dignissim aliquet.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Vandaag"),
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
          return new SingleChildScrollView(child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:8),
              ),
              _buildHeader(content),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Planning',
                style: TextStyle(fontSize: 35),
              ),
              _buildExpandablePlanning(content),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Hotel',
                style: TextStyle(fontSize: 35),
              ),
              _buildExpandableHotel(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Algemene info',
                style: TextStyle(fontSize: 35),
              ),
              _buildExpandableAlgemeneInfo(),
            ],
          ),);
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
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ]),
      ),
    ]);
  }

  Widget _buildExpandablePlanning(var content) {
    return Card(
      child: ExpandablePanel(
        collapsed: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            _planningText,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        expanded: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            content[0]['user']['first_name'],
            softWrap: true,
          ),
        ),
        tapHeaderToExpand: true,
        hasIcon: true,
      ),
    );
  }

  Widget _buildExpandableHotel() {
    return Card(
      child: ExpandablePanel(
        collapsed: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            _planningText,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        expanded: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            _planningText,
            softWrap: true,
          ),
        ),
        tapHeaderToExpand: true,
        hasIcon: true,
      ),
    );
  }

  Widget _buildExpandableAlgemeneInfo() {
    return Card(
      child: ExpandablePanel(
        collapsed: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            _planningText,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        expanded: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            _planningText,
            softWrap: true,
          ),
        ),
        tapHeaderToExpand: true,
        hasIcon: true,
      ),
    );
  }
}

/*Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Text(
'Time until departure:',
),
Text(
'$_counter' + ' days',
style: Theme.of(context).textTheme.display1,
),
],
),*/
