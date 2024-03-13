import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/viewmodel/dashboard/impaired_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          body: Padding(
            padding: UIHelper.pagePadding(context),
            child: Column(
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.04),
                _headlineText(context),
                UIHelper.emptySpaceHeight(context, 0.04),
                Container(
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
}
