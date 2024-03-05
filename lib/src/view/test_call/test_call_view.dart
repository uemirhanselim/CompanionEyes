import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:flutter/material.dart';

class TestCallView extends StatelessWidget {
  const TestCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(),
      body: Padding(
        padding: UIHelper.pagePadding(context),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
