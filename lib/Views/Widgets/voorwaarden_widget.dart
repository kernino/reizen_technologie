import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/ViewModel/AlgemeneInfoViewModel.dart';


class VoorwaardenConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: setConnection(),
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      child: Voorwaarden(),
      client: client,
    );
  }
}

class Voorwaarden extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VoorwaardenState();
}

class _VoorwaardenState extends State<Voorwaarden> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text(
            "Algemene voorwaarden",
            style: TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.red,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            child: getData(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Vandaag()),
            );
          },
          color: Colors.grey,
          textColor: Colors.white,
          child: Text('OK'),
        ),
      ),
    );
  }
}
