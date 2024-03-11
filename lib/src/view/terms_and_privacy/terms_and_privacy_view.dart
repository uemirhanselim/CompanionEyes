import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/viewmodel/terms_and_privacy/terms_and_privacy_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsAndPrivacyView extends StatelessWidget {
  const TermsAndPrivacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TermsAndPrivacyViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.02),
                _headlineText(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                _body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(context) => Column(
        children: <Widget>[
          _expansionTile(context, "Privacy Policy", ""),
          UIHelper.emptySpaceHeight(context, 0.02),
          _expansionTile(context, "Terms of Service", ""),
          UIHelper.emptySpaceHeight(context, 0.02),
        ],
      );

  ExpansionTile _expansionTile(context, String title, String description) =>
      ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
            color: UIHelper.saltwaterDenim,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: UIHelper.plaster,
        collapsedBackgroundColor: UIHelper.plaster,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        childrenPadding: EdgeInsets.only(
          bottom: UIHelper.getDynamicHeight(context, 0.012),
          left: UIHelper.getDynamicWidth(context, 0.042),
          right: UIHelper.getDynamicWidth(context, 0.042),
        ),
        expandedAlignment: Alignment.centerLeft,
        children: [
          SizedBox(
            height: UIHelper.getDynamicHeight(context, 0.6),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                style: TextStyle(
                  fontSize:
                      UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
                  color: UIHelper.formalGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _headlineText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Terms & Privacy\nPolicy",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
