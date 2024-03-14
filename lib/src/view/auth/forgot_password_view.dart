import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/auth/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child:
          Consumer<ForgotPasswordViewModel>(builder: (context, viewModel, _) {
        return Scaffold(
          appBar: const BackAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: UIHelper.pagePadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.emptySpaceHeight(context, 0.02),
                  _headlineText(context),
                  UIHelper.emptySpaceHeight(context, 0.05),
                  _fields(context),
                  UIHelper.emptySpaceHeight(context, 0.3),
                  _button(context, viewModel),
                  UIHelper.emptySpaceHeight(context, 0.04),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _button(BuildContext context, ForgotPasswordViewModel viewModel) =>
      SharedButton(
        color: UIHelper.black,
        title: "Reset Password",
        onPressed: viewModel.isResetButtonActive
            ? () async => viewModel.passwordResetEmailSend(context)
            : null,
      );

  Widget _fields(BuildContext context) => Consumer<ForgotPasswordViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: <Widget>[
              SharedTextFormField(
                title: "Email",
                controller: viewModel.emailController,
                focusNode: viewModel.emailFocusNode,
              ),
            ],
          );
        },
      );

  Text _headlineText(BuildContext context) => Text(
        "Enter your\nemail address.",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
