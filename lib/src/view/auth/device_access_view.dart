import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/viewmodel/auth/device_access_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DeviceAccessView extends StatelessWidget {
  const DeviceAccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeviceAccessViewModel(),
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

  Image get _asset => Image.asset(
        UIHelper.deviceAccessImage,
      );

  SharedButton _button(BuildContext context) => SharedButton(
        title: "Give Access",
        color: UIHelper.black,
        onPressed: () => context.router.replaceAll([const HomeRoute()]),
      );

  Text _definitionText(BuildContext context) => Text(
        "To make video calls, give access to your microphone and camera. To use wireless\nheadset, please give access to Bluetooth.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
          color: UIHelper.blackOut,
          fontWeight: FontWeight.w500,
        ),
      );

  Text _congratsText(BuildContext context) => Text(
        "Microphone, Camera and Bluetooth",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          fontWeight: FontWeight.w400,
          color: UIHelper.black,
        ),
      );
}
