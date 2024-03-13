import 'package:auto_route/auto_route.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/camera/camera_view.dart';
import 'package:companioneyes/src/view/dashboard/impaired_dashboard_view.dart';
import 'package:companioneyes/src/view/dashboard/volunteer_dashboard_view.dart';
import 'package:companioneyes/src/view/settings/settings_view.dart';
import 'package:companioneyes/src/viewmodel/dashboard/impaired_dashboard_viewmodel.dart';
import 'package:companioneyes/src/viewmodel/dashboard/volunteer_dashboard_viewmodel.dart';
import 'package:companioneyes/src/viewmodel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
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
          return AutoTabsScaffold(
              routes: viewModel.isVolunteer
                      ? _routesForVolunteer
                      : _routesForImpaired,
              backgroundColor: UIHelper.white,
              // body: viewModel.isPageLoading
              //     ? const Center(child: CircularProgressIndicator())
              //     : viewModel.isVolunteer
              //         ? _screensForVolunteer[viewModel.pageIndex]
              //         : _screensForImpaired[viewModel.pageIndex],
              bottomNavigationBuilder: (_, tabsRouter) {
                return CircleNavBar(
                  activeIndex: tabsRouter.activeIndex,
                  activeIcons: viewModel.isVolunteer
                      ? _activeIconsForVolunteer
                      : _activeIconsForImpaired,
                  inactiveIcons: viewModel.isVolunteer
                      ? _inactiveIconsForVolunteer
                      : _inactiveIconsForImpaired,
                  height: 70,
                  circleWidth: 62,
                  onTap: (index) => tabsRouter.setActiveIndex(index),
                  color: UIHelper.blackOut,
                  cornerRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  shadowColor: UIHelper.formalGrey,
                  elevation: 10,
                );
              });
        },
      ),
    );
  }
}

List<PageRouteInfo<dynamic>> _routesForImpaired = [
  const ImpairedDashboardRoute(),
  const CameraRoute(),
  const SettingsRoute(),
];

List<PageRouteInfo<dynamic>> _routesForVolunteer = [
  const VolunteerDashboardRoute(),
  const SettingsRoute(),
];

List<Icon> _inactiveIconsForVolunteer = <Icon>[
  const Icon(
    Icons.dashboard_outlined,
    color: UIHelper.white,
    size: 26,
  ),
  const Icon(
    Icons.settings_outlined,
    color: UIHelper.white,
    size: 26,
  ),
];

List<Icon> _inactiveIconsForImpaired = <Icon>[
  const Icon(
    Icons.videocam_outlined,
    color: UIHelper.white,
    size: 26,
  ),
  const Icon(
    Icons.camera_alt_outlined,
    color: UIHelper.white,
    size: 26,
  ),
  const Icon(
    Icons.settings_outlined,
    color: UIHelper.white,
    size: 26,
  ),
];

List<Icon> _activeIconsForVolunteer = <Icon>[
  const Icon(
    Icons.dashboard,
    color: UIHelper.white,
  ),
  const Icon(Icons.settings, color: UIHelper.white),
];

List<Icon> _activeIconsForImpaired = <Icon>[
  const Icon(
    Icons.videocam_outlined,
    color: UIHelper.white,
  ),
  const Icon(Icons.camera_alt_outlined, color: UIHelper.white),
  const Icon(Icons.settings, color: UIHelper.white),
];
