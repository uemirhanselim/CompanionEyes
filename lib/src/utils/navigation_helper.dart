import 'package:flutter/material.dart';

class NavigationHelper {
  static void pushNamed(BuildContext context, String routeName) =>
      Navigator.pushNamed(context, routeName);

  static void pushReplacementNamed(BuildContext context, String routeName) => 
      Navigator.pushReplacementNamed(context, routeName);

  static void pop(BuildContext context) => Navigator.pop(context);

  static void popUntil(BuildContext context, String routeName) =>
      Navigator.popUntil(context, ModalRoute.withName(routeName));

}