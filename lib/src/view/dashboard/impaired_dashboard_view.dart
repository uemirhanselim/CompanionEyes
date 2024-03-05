import 'package:companioneyes/src/viewmodel/dashboard/impaired_dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImpairedDashboardView extends StatelessWidget {
  const ImpairedDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImpairedDashboardViewModel(),
      child: const Scaffold(),
    );
  }
}
