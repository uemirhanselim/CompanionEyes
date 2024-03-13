import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/package/svg_image.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/viewmodel/auth/congrats_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CongratsView extends StatelessWidget {
  const CongratsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CongratsViewModel(),
      child: Scaffold(
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: Align(
            child: Column(
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.1),
                _asset,
                UIHelper.emptySpaceHeight(context, 0.04),
                _congratsText(context),
                UIHelper.emptySpaceHeight(context, 0.02),
                _definitionText(context),
                const Spacer(),
                _button(context),
                UIHelper.emptySpaceHeight(context, 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SvgImage get _asset => const SvgImage(
        assetName: UIHelper.successfulSvg,
      );

  SharedButton _button(BuildContext context) => SharedButton(
        title: "Go to Sign In",
        color: UIHelper.black,
        onPressed: () => context.router.replaceAll([const HomeRoute()]),
      );

  Text _definitionText(BuildContext context) => Text(
        "You have updated your password.\nNow navigate back to sign in screen.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize16),
          color: UIHelper.blackOut,
          fontWeight: FontWeight.w500,
        ),
      );

  Text _congratsText(BuildContext context) => Text(
        "Congrats!",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize28),
          fontWeight: FontWeight.bold,
          color: UIHelper.black,
        ),
      );
}
