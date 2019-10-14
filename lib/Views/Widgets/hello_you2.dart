import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'appbar.dart';
import 'package:reizen_technologie/ViewModel/GetAlgemeneInfo.dart';

class HelloYou2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
    HttpLink(uri: "http://171.25.229.102:8222/graphql?query=");
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer UkDSHeJHscD3wU5zmnSjXWQKLWZkWAz4vzs4TSuKAQrRXILDSL7iB9qy5Qhy',
    );
    final Link link = authLink.concat(httpLink);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: link,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      child: AlgemeneInfo(),
      client: client,
    );
  }
}

class AlgemeneInfo extends StatefulWidget {
  @override
  _AlgemeneInfo createState() => _AlgemeneInfo();
}

class _AlgemeneInfo extends State<AlgemeneInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarTest.getAppbar(),
      body: Query(
          options: QueryOptions(document: getAlgemeneData()),
          builder: (QueryResult result, {
            BoolCallback refetch,
            FetchMore fetchMore,
          }){
            return ListView.builder(itemBuilder: (BuildContext context, int index){
              index = 0;
              return Text(result.data['info'][index]['info_value']);
            },
              itemCount: result.data['info'].length,
            );
          }),
    );
  }
}