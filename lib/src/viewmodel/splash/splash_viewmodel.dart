import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel(BuildContext context) {
// Add your initialization code here
    print("girdi");
    context.pushRoute(const HomeRoute());
    //_init(context);
  }
// Setters
// Getters
// Other methods
  Future<void> _init(BuildContext context) async {
    print("HEllo");
    await Future.delayed(const Duration(seconds: 2), () async {
      print("mello");
      await context.pushRoute(const HomeRoute());
    });
  }
}
