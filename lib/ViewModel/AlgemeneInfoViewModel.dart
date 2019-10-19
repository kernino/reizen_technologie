import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reizen_technologie/Model/globals.dart' as globals;

String getAlgemeneData() {
  String data =  """
    query{
      info{
        info_value
      }
    }
    """;
  return data;
}


Link setConnection(){
  var bearer = globals.loggedInUser;
  print(bearer);
  final HttpLink httpLink =  HttpLink(uri: "http://171.25.229.102:8222/graphql?query=");
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer ' + globals.loggedInUser[0]["token"]);
  final Link link = authLink.concat(httpLink);
  return link;
}

Query getData(){
  Query a = Query(
      options: QueryOptions(document: getAlgemeneData()),
      builder: (QueryResult result, {
        BoolCallback refetch,
        FetchMore fetchMore,
      }) {
        if (result.data == null) {
          return Text("loading...");
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text(result.data['info'][index]['info_value']);
          },
          itemCount: result.data['info'].length,
          scrollDirection: Axis.vertical,
        );
      });
  return a;
}



