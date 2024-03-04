import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/viewmodel/auth/congrats_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
                SvgPicture.asset(
                  UIHelper.successfulSvg,
                ),
                UIHelper.emptySpaceHeight(context, 0.04),
                Text(
                  "Congrats!",
                  style: TextStyle(
                    fontSize: UIHelper.getDynamicFontSize(
                        context, UIHelper.fontSize28),
                    fontWeight: FontWeight.bold,
                    color: UIHelper.black,
                  ),
                ),
                UIHelper.emptySpaceHeight(context, 0.02),
                Text(
                  "You have updated your password.\nNow navigate back to sign in screen.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: UIHelper.getDynamicFontSize(
                        context, UIHelper.fontSize16),
                    color: UIHelper.blackOut,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                SharedButton(
                  title: "Go to Sign In",
                  color: UIHelper.black,
                  onPressed: () {},
                ),
                UIHelper.emptySpaceHeight(context, 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
