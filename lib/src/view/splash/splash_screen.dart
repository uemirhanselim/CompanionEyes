import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/viewmodel/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(),
      child: Scaffold(
        backgroundColor: UIHelper.saltwaterDenim,
        body: _centerWidget(),
      ),
    );
  }

  Center _centerWidget() {
    return Center(
      child: _appLogo(),
    );
  }

  Image _appLogo() => Image.asset(UIHelper.appLogoIcon);
}
