import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/dashboard/impaired_dashboard_view.dart';
import 'package:companioneyes/src/view/dashboard/volunteer_dashboard_view.dart';
import 'package:companioneyes/src/view/settings/settings_view.dart';
import 'package:companioneyes/src/viewmodel/dashboard/impaired_dashboard_viewmodel.dart';
import 'package:companioneyes/src/viewmodel/dashboard/volunteer_dashboard_viewmodel.dart';
import 'package:companioneyes/src/viewmodel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(create: (_) => VolunteerDashboardViewModel()),
        ChangeNotifierProvider(create: (_) => ImpairedDashboardViewModel()),
      ],
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, index) {
          return Scaffold(
            backgroundColor: UIHelper.white,
            body: viewModel.isPageLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.isVolunteer
                    ? _screensForVolunteer[viewModel.pageIndex]
                    : _screensForImpaired[viewModel.pageIndex],
            bottomNavigationBar: CircleNavBar(
              activeIndex: viewModel.pageIndex,
              activeIcons: const <Icon>[
                Icon(
                  Icons.dashboard,
                  color: UIHelper.white,
                ),
                Icon(Icons.settings, color: UIHelper.white),
              ],
              inactiveIcons: const <Icon>[
                Icon(
                  Icons.dashboard_outlined,
                  color: UIHelper.white,
                  size: 26,
                ),
                Icon(
                  Icons.settings_outlined,
                  color: UIHelper.white,
                  size: 26,
                ),
              ],
              height: 70,
              circleWidth: 62,
              onTap: (index) => viewModel.setPageIndex = index,
              color: UIHelper.blackOut,
              cornerRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              shadowColor: UIHelper.formalGrey,
              elevation: 10,
            ),
          );
        },
      ),
    );
  }
}

List<Widget> _screensForImpaired = <Widget>[
  const ImpairedDashboardView(),
  const SettingsView(),
];

List<Widget> _screensForVolunteer = <Widget>[
  const VolunteerDashboardView(),
  const SettingsView(),
];
