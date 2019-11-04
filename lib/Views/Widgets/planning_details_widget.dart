import 'package:flutter/material.dart';
import 'package:reizen_technologie/ViewModel/DayPlanningViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/planning_widget.dart';
import 'appbar.dart';

class PlanningDetailsPage extends StatefulWidget {
  PlanningDetailsPage({Key key, this.dayPlanning}) : super(key: key);

  final int dayPlanning;

  @override
  _PlanningDetailsPageState createState() => _PlanningDetailsPageState();
}

class _PlanningDetailsPageState extends State<PlanningDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder(
          future: GetDayPlanningData(widget.dayPlanning),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var content = snapshot.data;
            if (!snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done) {
                content = [];
              }
              return CircularProgressIndicator();
            }
            return Scaffold(
              appBar: Appbar.getAppbar(
                content[0]['name'],
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlanningPage()),
                        )),
              ),
              body: new Column(
                children: <Widget>[
                  Text(content[0]['description']),
                ],
              ),
            );
          }),
    );
  }
}