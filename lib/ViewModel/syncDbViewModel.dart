import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reizen_technologie/Views/Widgets/vandaag_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/ViewModel/AlgemeneInfoViewModel.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;


class SyncConnection extends StatelessWidget {
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
      child: Sync(),
      client: client,
    );
  }
}

class Sync extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SyncState();
}

class _SyncState extends State<Sync> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
          options: QueryOptions(document: getAllDataToSync()),
          builder: (QueryResult result, {
            BoolCallback refetch,
            FetchMore fetchMore,
          }) {
            if (result.data == null) {
              return Text(result.errors.toString());
            }
            else{
              return result.data['hotel'];
            }
          }),
    );
  }
}

Link setConnection(){
  var bearer = globals.loggedInUser[0]["token"];
  print(bearer);
  final HttpLink httpLink =  HttpLink(uri: "http://171.25.229.102:8222/graphql?query=");
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ' + bearer);
  final Link link = authLink.concat(httpLink);
  return link;
}

void syncDbToLocal()
{

}

String getAllDataToSync() {
  String data ="""
    query{

    }
    """;
  return data;
}
