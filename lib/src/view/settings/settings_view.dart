import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/shared_button_with_icon.dart';
import 'package:companioneyes/src/viewmodel/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: Scaffold(
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.04),
                _headlineText(context),
                UIHelper.emptySpaceHeight(context, 0.02),
                _profileSection(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                _languageSection(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                _feedbackSection(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                _versionText(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _versionText(BuildContext context) => Align(
        child: Text(
          "Version 0.0.1",
          style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize11),
              fontWeight: FontWeight.w600),
        ),
      );

  Column _profileSection(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(context, "Profile"),
          UIHelper.emptySpaceHeight(context, 0.012),
          SharedButtonWithIcon(
            title: "Personal Details",
            isSettings: false,
            onPressed: () => context.router.push(const EditProfileRoute()),
          ),
          UIHelper.emptySpaceHeight(context, 0.012),
          SharedButtonWithIcon(
            title: "Change Password",
            isSettings: false,
            onPressed: () => context.router.push(const ChangePasswordRoute()),
          ),
          UIHelper.emptySpaceHeight(context, 0.012),
          SharedButtonWithIcon(
            title: "Change Phone Number",
            isSettings: false,
            onPressed: () {},
          ),
        ],
      );

  Column _languageSection(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(context, "Languages"),
          UIHelper.emptySpaceHeight(context, 0.012),
          _languageBox(context),
          UIHelper.emptySpaceHeight(context, 0.012),
          _languageInfoText(context),
        ],
      );

  Padding _languageInfoText(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: UIHelper.getDynamicWidth(context, 0.01)),
        child: Text(
          "When you request help, you will be connected to the first available volunteer who speaks your primary language.",
          style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize11),
              fontWeight: FontWeight.w600),
        ),
      );

  Column _feedbackSection(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionHeader(context, "Support and Feedback"),
          UIHelper.emptySpaceHeight(context, 0.012),
          SharedButtonWithIcon(
            title: "FAQ",
            isSettings: true,
            iconPath: UIHelper.questionMarkIcon,
            onPressed: () => context.router.push(const FaqRoute()),
          ),
          UIHelper.emptySpaceHeight(context, 0.012),
          SharedButtonWithIcon(
            title: "Send us Feedback",
            isSettings: true,
            iconPath: UIHelper.warningDialogIcon,
            onPressed: () => context.router.push(const FeedbackRoute()),
          ),
          UIHelper.emptySpaceHeight(context, 0.012),
          SharedButtonWithIcon(
            title: "Terms & Privacy Policy",
            isSettings: true,
            iconPath: UIHelper.shieldIcon,
            onPressed: () => context.router.push(const TermsAndPrivacyRoute()),
          ),
        ],
      );

  Padding _sectionHeader(BuildContext context, String header) => Padding(
        padding: EdgeInsets.only(left: UIHelper.getDynamicWidth(context, 0.01)),
        child: Text(
          header,
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _headlineText(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.logout_rounded,
            color: UIHelper.black,
            size: UIHelper.getDynamicFontSize(context, UIHelper.fontSize28),
          ),
        ],
      );

  Widget _languageBox(BuildContext context) =>
      Consumer<SettingsViewModel>(builder: (context, viewModel, _) {
        return SizedBox(
          height: UIHelper.getDynamicHeight(context, 0.06),
          width: UIHelper.getDynamicWidth(context, 1),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: UIHelper.plaster,
                elevation: 0,
              ),
              onPressed: () => context.router.push(const LanguageEditRoute()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Primary Language",
                        style: TextStyle(
                            fontSize: UIHelper.getDynamicFontSize(
                              context,
                              UIHelper.fontSize14,
                            ),
                            color: UIHelper.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "English",
                        style: TextStyle(
                            fontSize: UIHelper.getDynamicFontSize(
                              context,
                              UIHelper.fontSize12,
                            ),
                            color: UIHelper.formalGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right, color: UIHelper.black),
                ],
              )),
        );
      });
}
