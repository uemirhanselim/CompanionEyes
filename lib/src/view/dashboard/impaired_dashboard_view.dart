import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/viewmodel/dashboard/impaired_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class ImpairedDashboardView extends StatelessWidget {
  const ImpairedDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImpairedDashboardViewModel(),
      child: Consumer<ImpairedDashboardViewModel>(
          builder: (context, viewModel, _) {
        return Scaffold(
          body: !viewModel.isPageLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: UIHelper.pagePadding(context),
                  child: viewModel.isVolunteer
                      ? Align(
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
                        )
                      : Column(
                          children: <Widget>[
                            UIHelper.emptySpaceHeight(context, 0.04),
                            _headlineText(context),
                            UIHelper.emptySpaceHeight(context, 0.04),
                            InkWell(
                              onTap: () async {
                                final vm =
                                    context.read<ImpairedDashboardViewModel>();
                                await showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                    value: vm,
                                    child: const _Dialog(),
                                  ),
                                );
                                // context.router
                                //     .push(VideoCallRoute(pRoomId: null));
                              },
                              child: Container(
                                height: UIHelper.getDynamicHeight(context, 0.6),
                                decoration: BoxDecoration(
                                  color: UIHelper.saltwaterDenim,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                    child: Text(
                                  "Call a Volunteer",
                                  style: TextStyle(
                                    color: UIHelper.white,
                                    fontSize: UIHelper.getDynamicFontSize(
                                        context, UIHelper.fontSize38),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                ),
        );
      }),
    );
  }

  Align _headlineText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Get live video support",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize28),
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  // --------------------------- Volunteer Widgets ---------------------------

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
}

class _Dialog extends StatelessWidget {
  const _Dialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImpairedDashboardViewModel>();
    return Dialog(
      insetPadding: UIHelper.pagePadding(context) +
          EdgeInsets.only(top: UIHelper.getDynamicHeight(context, 0.07)),
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: UIHelper.getDynamicHeight(context, 0.7),
        width: UIHelper.getDynamicWidth(context, 1),
        child: Padding(
          padding: EdgeInsets.all(
            UIHelper.getDynamicHeight(context, 0.02),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "Specify your help request",
                    style: TextStyle(
                        fontSize: UIHelper.getDynamicFontSize(
                            context, UIHelper.fontSize22),
                        fontWeight: FontWeight.w600),
                  ),
                  UIHelper.emptySpaceHeight(context, 0.1),
                  Text(
                    viewModel.lastWords,
                    style: TextStyle(
                        fontSize: UIHelper.getDynamicFontSize(
                            context, UIHelper.fontSize14),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onLongPressStart: (details) async {
                      viewModel.setSpeakButtonPressed = true;
                      bool canVibrate = await Vibrate.canVibrate;
                      if (canVibrate) {
                        Vibrate.vibrate();
                      }
                      await viewModel.startListening();
                    },
                    onLongPressEnd: (details) async {
                      viewModel.setSpeakButtonPressed = false;
                      bool canVibrate = await Vibrate.canVibrate;
                      if (canVibrate) {
                        Vibrate.vibrate();
                      }
                      await viewModel.stopListening();
                    },
                    child: Container(
                      height: UIHelper.getDynamicHeight(context, 0.15),
                      decoration: BoxDecoration(
                        color: UIHelper.saltwaterDenim,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        viewModel.speakButtonPressed
                            ? "Release to stop"
                            : "Hold to speak",
                        style: TextStyle(
                          color: UIHelper.white,
                          fontSize: UIHelper.getDynamicFontSize(
                              context, UIHelper.fontSize32),
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                  UIHelper.emptySpaceHeight(context, 0.02),
                  GestureDetector(
                    onTap: () async {
                      context.router.push(VideoCallRoute(
                          pRoomId: null,
                          helpDefinition: viewModel.isLastWordsChanged
                              ? viewModel.lastWords
                              : "A Visually Impaired User Needs Your Help!"));
                    },
                    child: Container(
                      height: UIHelper.getDynamicHeight(context, 0.15),
                      decoration: BoxDecoration(
                        color: UIHelper.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: UIHelper.saltwaterDenim,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "Start Video Call",
                        style: TextStyle(
                          color: UIHelper.saltwaterDenim,
                          fontSize: UIHelper.getDynamicFontSize(
                              context, UIHelper.fontSize32),
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                  UIHelper.emptySpaceHeight(context, 0.02),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
