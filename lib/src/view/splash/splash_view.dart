import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/viewmodel/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(context),
      child: Consumer<SplashViewModel>(builder: (context, viewmodel, _) {
        return Scaffold(
          backgroundColor: UIHelper.saltwaterDenim,
          body: _centerWidget,
        );
      }),
    );
  }

  Center get _centerWidget => Center(
        child: _appLogo,
      );

  Image get _appLogo => Image.asset(UIHelper.appLogoIcon);
}
