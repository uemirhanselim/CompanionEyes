import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_button_with_icon.dart';
import 'package:companioneyes/src/viewmodel/auth/privacy_and_terms_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PrivacyAndTermsView extends StatelessWidget {
  const PrivacyAndTermsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PrivacyAndTermsViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: Align(
            child: Column(
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.02),
                _headlineText(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                _topText(context),
                UIHelper.emptySpaceHeight(context, 0.02),
                _infoPart(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                _termsAndPolicyButtons(context),
                const Spacer(),
                _bottomPart(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _bottomPart(BuildContext context) => Column(
        children: [
          Text(
            "By clicking 'I agree', I agree to everything above and accept the Terms of Service and Privacy Policy.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedButton(
            title: "I agree",
            color: UIHelper.black,
            onPressed: () {},
          ),
          UIHelper.emptySpaceHeight(context, 0.04),
        ],
      );

  Column _termsAndPolicyButtons(BuildContext context) => Column(
        children: [
          SharedButtonWithIcon(
            title: "Terms of Service",
            isSettings: false,
            onPressed: () {},
          ),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedButtonWithIcon(
            title: "Privacy Policy",
            isSettings: false,
            onPressed: () {},
          ),
        ],
      );

  Widget _infoPart(BuildContext context) => Column(
        children: [
          _infoTile(context, Icons.directions_walk_rounded,
              "I will not use CompanionEyes as a mobility device."),
          UIHelper.emptySpaceHeight(context, 0.02),
          _infoTile(context, Icons.photo_camera_rounded,
              "CompanionEyes can review, and share video for safety, quality and as further described in the Privacy Policy."),
          UIHelper.emptySpaceHeight(context, 0.02),
          _infoTile(context, Icons.lock,
              "The data and personal information I submit to CompanionEyes may be stored and processed in Türkiye."),
        ],
      );

  Row _infoTile(BuildContext context, IconData icon, String text) => Row(
        children: [
          _iconAvatar(context, icon),
          UIHelper.emptySpaceWidth(context, 0.05),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );

  CircleAvatar _iconAvatar(BuildContext context, IconData icon) => CircleAvatar(
        backgroundColor: UIHelper.black,
        radius: UIHelper.getDynamicFontSize(context, 0.03),
        child: Icon(
          icon,
          size: UIHelper.getDynamicFontSize(context, 0.034),
          color: UIHelper.white,
        ),
      );

  Text _headlineText(BuildContext context) => Text(
        "Privacy and Terms",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize28),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _topText(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: UIHelper.getDynamicWidth(context, 0.05)),
        child: Text(
          "To use CompanionEyes, you agree to the following:",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
