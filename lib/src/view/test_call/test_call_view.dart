import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TestCallView extends StatelessWidget {
  const TestCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: Padding(
        padding: UIHelper.pagePadding(context),
        child: const Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
