
import 'package:flutter/material.dart';

class AppRouter {

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static NavigatorToWidget(Widget widget){
    Navigator.of(navKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static popFromWidget(){
    Navigator.of(navKey.currentContext!).pop();
  }

  static NavigatorToWidgetWithReplacement(Widget widget){
    Navigator.of(navKey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }

  



}