import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/ViewModel/VoorwaardenViewModel.dart';

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
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Algemene voorwaarden", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(224, 0, 73, 1.0),
      ),
      body: Scrollbar(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    height: MediaQuery.of(context).size.height - 215,
                    child: getData()),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: _isButtonDisabled,
                            onChanged: (bool newValue) {
                              setState(
                                  () => _isButtonDisabled = !_isButtonDisabled);
                            }),
                        Text('Gelezen en goedgekeurd')
                      ],
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      onPressed: !_isButtonDisabled
                          ? null
                          : () {
                              acceptConditions(context);
                            },
                      color: Color.fromRGBO(224, 0, 73, 1.0),
                      textColor: Colors.white,
                      child:
                          Text('Ik ga akkoord', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
