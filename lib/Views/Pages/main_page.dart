//navigatie bij opstarten
//verwijzen naar alle pagina's die worden toegevoegd

import 'package:flutter/material.dart';
import 'package:reizen_technologie/ViewModels/main_page_viewmodel.dart';

class MainPage extends StatefulWidget {
  final MainPageViewModel viewModel;

  MainPage({Key key, @required this.viewModel}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

/*
  Future loadData() async {
    await widget.viewModel.setFilms();
    await widget.viewModel.setCharacters();
    await widget.viewModel.setPlanets();
  }*/

/*@override
  void initState(){
  super.initState();
}*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(centerTitle: true, title: Text("test")));
  }
}
