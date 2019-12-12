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
      appBar: Appbar.getAppbar("Planning", context),
      body: new FutureBuilder(
          future: GetDayPlannings(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var content;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return Center(child: CircularProgressIndicator());
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
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                                content[index]['location'],
                                style: TextStyle(fontSize: 35)
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
                                        dayPlanning: content[index]
                                            ['id'])),
                              );
                            },
                            child: Center(
                              child: new Card(
                                elevation: 2,
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
