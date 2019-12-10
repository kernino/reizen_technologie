import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:reizen_technologie/ViewModel/VandaagViewModel.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';
import 'appbar.dart';

class AlgemeneInfo extends StatelessWidget {
  AlgemeneInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algemene info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        //Color.fromRGBO(255, g, b, opacity),
        //Colors.red,
      ),
      home: AlgemeneInfoPage(),
    );
  }
}

class AlgemeneInfoPage extends StatefulWidget {
  AlgemeneInfoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AlgemeneInfoPageState createState() => _AlgemeneInfoPageState();
}

class _AlgemeneInfoPageState extends State<AlgemeneInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.getAppbar(
        "Algemene info",
        context,
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => VandaagPage()),
          ),
        ),
      ),
      body: new FutureBuilder(
        future: GetInfo(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var content;
          if (!snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              content = [];
            }
            return Center(child: CircularProgressIndicator());
          }
          content = snapshot.data;
          String algemeneInfoString = content[0]['info'];

          return new Scrollbar(
              child: Padding(
            padding: EdgeInsets.only(top: 10, right: 5, bottom: 10),
            child: SingleChildScrollView(
                child: Html(
              data: algemeneInfoString + algemeneInfoString,
            )),
          ));
        },
      ),
    );
  }





}
