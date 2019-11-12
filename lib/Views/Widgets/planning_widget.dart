import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';
import 'package:reizen_technologie/ViewModel/DayPlanningViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/planning_details_widget.dart';

class PlanningPage extends StatefulWidget {
  PlanningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  var titelWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar("Planning"),
      body: new FutureBuilder(
          future: GetDayPlannings(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var content;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return CircularProgressIndicator();
            }
            content = snapshot.data;

            String location = "";
            return new Scaffold(
              body: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(content.length, (index) {
                      titelWidget = Visibility(
                        child: Text(content[index]['location']),
                        visible: false,
                      );

                      if (location != content[index]['location']) {
                        titelWidget = Visibility(
                          child: Text(
                            content[index]['location'],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          visible: true,
                        );
                      }
                      location = content[index]['location'];

                      return Column(
                        children: <Widget>[
                          titelWidget,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlanningDetailsPage(
                                        dayPlanning: snapshot.data[index]
                                            ['id'])),
                              );
                            },
                            child: Center(
                              child: new Card(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text("day " +
                                            (index + 1).toString() +
                                            ": " +
                                            content[index]['highlight'],
                                          style: TextStyle(
                                            fontSize: 18
                                          ),
                                        ),
                                        subtitle: Text(
                                          content[index]['date'],
                                          style: TextStyle(
                                            fontSize: 18
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

//widget met hardcoded data
/*
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar(widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Title(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "City 1",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: Color.fromRGBO(0, 0, 0, 1.0),
              title: "City 1",
            ),
            Card(
              child: const ListTile(
                title: Text('Day 1'),
                subtitle: Text('17/05 - 18/05'),
              ),
            ),
            Card(
              child: const ListTile(
                title: Text('Day 2'),
                subtitle: Text('18/05 - 19/05'),
              ),
            ),
            Card(
              child: const ListTile(
                title: Text('Day 3'),
                subtitle: Text('19/05 - 20/05'),
              ),
            ),
            Title(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "City 2",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: Color.fromRGBO(0, 0, 0, 1.0),
              title: "City 2",
            ),
            Card(
              child: const ListTile(
                title: Text('Day 4'),
                subtitle: Text('21/05 - 22/05'),
              ),
            ),
            Card(
              child: const ListTile(
                title: Text('Day 5'),
                subtitle: Text('22/05 - 23/05'),
              ),
            ),
            Card(
              child: const ListTile(
                title: Text('Day 3'),
                subtitle: Text('24/05 - 25/05'),
              ),
            ),
            Title(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "City 3",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: Color.fromRGBO(0, 0, 0, 1.0),
              title: "City 3",
            ),
            Card(
              child: const ListTile(
                title: Text('Day 7'),
                subtitle: Text('26/05 - 27/05'),
              ),
            ),
          ],
        ),
      ),
    );
  }
 */
