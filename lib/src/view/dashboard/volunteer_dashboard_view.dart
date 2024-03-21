import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/viewmodel/dashboard/volunteer_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class VolunteerDashboardView extends StatelessWidget {
  const VolunteerDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VolunteerDashboardViewModel(),
      child: Scaffold(
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: Align(
            child: Column(
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.04),
                _image(context),
                _card(context, _personalData(context)),
                UIHelper.emptySpaceHeight(context, 0.02),
                _answerCallButton(context),
                UIHelper.emptySpaceHeight(context, 0.02),
                _card(
                  context,
                  _notificationText(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton _answerCallButton(BuildContext context) => TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {
        debugPrint("Navigation stack 10: ${context.router.current.path}");
        context.router.push(const TestCallRoute());
        debugPrint("Navigation stack 11: ${context.router.current.path}");
      },
      child: _card(context, _answerCallText(context), isSmall: true));

  Text _answerCallText(BuildContext context) => _text(
      context, "Learn to answer a call", UIHelper.fontSize15, UIHelper.white);

  Text _notificationText(BuildContext context) => _text(
      context,
      "You will recieve a notification when someone needs your help.",
      UIHelper.fontSize15,
      UIHelper.blackOut);

  Image _image(BuildContext context) => Image.asset(
        UIHelper.appLogoIcon,
        scale: UIHelper.getDynamicFontSize(context, 0.0009),
      );

  Container _card(BuildContext context, Widget child, {bool isSmall = false}) =>
      Container(
        height: UIHelper.getDynamicHeight(context, isSmall ? 0.07 : 0.12),
        width: UIHelper.getDynamicWidth(context, 0.9),
        decoration: BoxDecoration(
          color: isSmall ? UIHelper.saltwaterDenim : UIHelper.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: UIHelper.blackOut.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(UIHelper.getDynamicHeight(context, 0.015)),
          child: Center(child: child),
        ),
      );

  Column _personalData(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _text(
              context, "Hello Emirhan", UIHelper.fontSize15, UIHelper.blackOut),
          _text(context, "Member since 14 December 2023", UIHelper.fontSize15,
              UIHelper.formalGrey),
          _languageBox(context),
        ],
      );

  Container _languageBox(BuildContext context) => Container(
      height: UIHelper.getDynamicHeight(context, 0.03),
      width: UIHelper.getDynamicWidth(context, 0.2),
      decoration: const BoxDecoration(
        color: UIHelper.plaster,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Center(
        child:
            _text(context, "English", UIHelper.fontSize12, UIHelper.formalGrey),
      ));

  Text _text(BuildContext context, String text, double size, Color color) =>
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: UIHelper.getDynamicFontSize(context, size),
          fontWeight: FontWeight.w600,
        ),
      );
}
