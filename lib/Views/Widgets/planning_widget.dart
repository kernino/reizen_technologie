import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/appbar.dart';

class Planning extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reizen technologie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //Color.fromRGBO(255, g, b, opacity),
        //Colors.red,
      ),
      home: PlanningPage(title: 'Planning'),
    );
  }
}

class PlanningPage extends StatefulWidget {
  PlanningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar(widget.title),
      body: Scrollbar(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Title(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "City 1",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}
