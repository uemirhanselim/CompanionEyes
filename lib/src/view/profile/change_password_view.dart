import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/profile/change_passport_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child:
          Consumer<ChangePasswordViewModel>(builder: (context, viewModel, _) {
        return GestureDetector(
          onTap: () {
            viewModel.currentPasswordFocusNode.unfocus();
            viewModel.newPasswordFocusNode.unfocus();
          },
          child: Scaffold(
            appBar: const BackAppBar(),
            body: Padding(
              padding: UIHelper.pagePadding(context),
              child: Column(
                children: <Widget>[
                  UIHelper.emptySpaceHeight(context, 0.02),
                  _headlineText(context),
                  UIHelper.emptySpaceHeight(context, 0.04),
                  _textFields(context, viewModel),
                  const Spacer(),
                  _button,
                  UIHelper.emptySpaceHeight(context, 0.02),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  SharedButton get _button => SharedButton(
        title: "Update Password",
        color: UIHelper.black,
        onPressed: () {},
      );

  Widget _textFields(BuildContext context, ChangePasswordViewModel viewModel) =>
      Column(
        children: <Widget>[
          SharedTextFormField(
              title: "Current Password",
              controller: viewModel.currentPasswordController,
              focusNode: viewModel.currentPasswordFocusNode),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
              title: "New Password",
              controller: viewModel.newPasswordController,
              focusNode: viewModel.newPasswordFocusNode),
        ],
      );

  Widget _headlineText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Change Password",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
