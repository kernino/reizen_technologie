import 'package:flutter/cupertino.dart';

abstract class HelloYouModel {
  static String name;
  void setName(String string);
  void navigate(BuildContext context);
}