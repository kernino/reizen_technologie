import 'package:flutter/material.dart';
import 'package:reizen_technologie/ViewModels/main_page_viewmodel.dart';

import 'Views/Pages/main_page.dart';

final MainPageViewModel main_pageVM = MainPageViewModel();

void main() => runApp(MyApp(main_pageVM: main_pageVM));

class MyApp extends StatelessWidget {
  final MainPageViewModel main_pageVM;

  MyApp({@required this.main_pageVM});

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Flutter MVVM Demo',
      theme: new ThemeData(
        primaryColor: Color(0xff070707),
        primaryColorLight: Color(0xff0a0a0a),
        primaryColorDark: Color(0xff000000),
      ),
      home: MainPage(viewModel: main_pageVM),
      debugShowCheckedModeBanner: false,
    );
  }
}