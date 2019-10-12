import 'package:reizen_technologie/Model/HelloYouModel.dart';


class HelloYouViewModel implements HelloYouModel {

  static String name;


  void setName(String string) {
    name = string;
    print("Name: " + name);
  }





}