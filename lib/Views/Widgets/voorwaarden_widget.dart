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
        title:
            Text("Algemene voorwaarden", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Scrollbar(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    height: MediaQuery.of(context).size.height -200,
                    child: getData()),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    padding: const EdgeInsets.all(10.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Vandaag()),
                      );
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child:
                        Text('Ik ga akkoord', style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

/*body: CustomScrollView(
slivers: <Widget>[
SliverFillRemaining(
child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ac purus eget mi mollis tempus a in diam. Vivamus sagittis erat velit, at sagittis mauris sollicitudin id. Sed semper pharetra felis, eu sollicitudin leo ultricies non. Quisque molestie, nisl nec volutpat maximus, metus turpis egestas nulla, et consequat est risus dapibus lorem. Nunc quis dui ut massa ultrices aliquam. Cras volutpat in ipsum eu rutrum. Nam rhoncus sem vitae feugiat euismod. Praesent iaculis nisi metus, ornare pellentesque massa posuere non. Ut eu diam mauris. Nam vulputate, elit auctor scelerisque eleifend, justo metus pharetra ipsum, eget porta massa velit et nisi. Sed a nisl felis. Sed sem tellus, consequat eget pulvinar et, congue nec dui.' +
'Pellentesque erat massa, ornare eu vestibulum non, dictum et arcu. Fusce nec mattis odio, id semper enim. Duis urna turpis, mattis a interdum nec, gravida a arcu. Phasellus ac ipsum turpis. Vestibulum iaculis rutrum tortor in ultrices. Integer a malesuada massa. Nunc consequat risus at nisi accumsan, in luctus massa imperdiet.' +
'Vestibulum hendrerit neque sem, imperdiet luctus arcu lobortis suscipit. Maecenas metus velit, pretium eget ipsum non, interdum volutpat enim. Aliquam ut ullamcorper nunc. Phasellus dictum sodales tortor sed imperdiet. Vivamus interdum quam ut sagittis elementum. Duis et nisi quis mauris semper hendrerit ut eu arcu. Proin nec volutpat diam. Integer vel venenatis massa.' +
'Maecenas luctus vitae risus ut egestas. Pellentesque sed massa laoreet, viverra dui egestas, finibus dui. Curabitur consectetur ex at eleifend ornare. Aenean ullamcorper tellus at odio sollicitudin, eu ullamcorper ex faucibus. Nullam tincidunt consequat posuere. Nulla consequat iaculis metus, a malesuada nisi cursus porttitor. In in magna condimentum, tristique massa ut, lobortis nunc. Nunc egestas laoreet lacus, sit amet faucibus purus lobortis vitae. Etiam a diam eget augue lobortis vulputate. Praesent ipsum mauris, convallis ac volutpat non, finibus eu magna. In hac habitasse platea dictumst. Donec id varius dolor. Quisque luctus risus ac mauris mattis, id posuere sapien bibendum. Cras tincidunt interdum lacus, eget eleifend nibh pellentesque et. Nam eget ultricies ante. Sed aliquam egestas felis, vitae placerat felis finibus sed.' +
'Praesent molestie consequat auctor. Morbi vel risus sit amet dui efficitur mattis vulputate id ex. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi congue cursus velit, ut molestie odio. Fusce gravida nunc et neque tincidunt rhoncus at eget enim. Nullam vitae diam tempus augue tempor tincidunt. Nullam elementum porttitor semper. Aenean fringilla, lorem gravida placerat sodales, nibh ante posuere metus, eget aliquam justo sem consequat nisi. Nam placerat turpis vehicula, volutpat augue sed, posuere lectus. Vivamus aliquam massa sed tempus blandit.'
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ac purus eget mi mollis tempus a in diam. Vivamus sagittis erat velit, at sagittis mauris sollicitudin id. Sed semper pharetra felis, eu sollicitudin leo ultricies non. Quisque molestie, nisl nec volutpat maximus, metus turpis egestas nulla, et consequat est risus dapibus lorem. Nunc quis dui ut massa ultrices aliquam. Cras volutpat in ipsum eu rutrum. Nam rhoncus sem vitae feugiat euismod. Praesent iaculis nisi metus, ornare pellentesque massa posuere non. Ut eu diam mauris. Nam vulputate, elit auctor scelerisque eleifend, justo metus pharetra ipsum, eget porta massa velit et nisi. Sed a nisl felis. Sed sem tellus, consequat eget pulvinar et, congue nec dui.' +
'Pellentesque erat massa, ornare eu vestibulum non, dictum et arcu. Fusce nec mattis odio, id semper enim. Duis urna turpis, mattis a interdum nec, gravida a arcu. Phasellus ac ipsum turpis. Vestibulum iaculis rutrum tortor in ultrices. Integer a malesuada massa. Nunc consequat risus at nisi accumsan, in luctus massa imperdiet.' +
'Vestibulum hendrerit neque sem, imperdiet luctus arcu lobortis suscipit. Maecenas metus velit, pretium eget ipsum non, interdum volutpat enim. Aliquam ut ullamcorper nunc. Phasellus dictum sodales tortor sed imperdiet. Vivamus interdum quam ut sagittis elementum. Duis et nisi quis mauris semper hendrerit ut eu arcu. Proin nec volutpat diam. Integer vel venenatis massa.' +
'Maecenas luctus vitae risus ut egestas. Pellentesque sed massa laoreet, viverra dui egestas, finibus dui. Curabitur consectetur ex at eleifend ornare. Aenean ullamcorper tellus at odio sollicitudin, eu ullamcorper ex faucibus. Nullam tincidunt consequat posuere. Nulla consequat iaculis metus, a malesuada nisi cursus porttitor. In in magna condimentum, tristique massa ut, lobortis nunc. Nunc egestas laoreet lacus, sit amet faucibus purus lobortis vitae. Etiam a diam eget augue lobortis vulputate. Praesent ipsum mauris, convallis ac volutpat non, finibus eu magna. In hac habitasse platea dictumst. Donec id varius dolor. Quisque luctus risus ac mauris mattis, id posuere sapien bibendum. Cras tincidunt interdum lacus, eget eleifend nibh pellentesque et. Nam eget ultricies ante. Sed aliquam egestas felis, vitae placerat felis finibus sed.'),
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
),*/
