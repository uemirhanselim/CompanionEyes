import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/auth/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage()
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
create: (_) {
  final viewModel = ForgotPasswordViewModel();
  viewModel.init();
  return viewModel;
},
      child: Scaffold(
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
                _button(context),
                UIHelper.emptySpaceHeight(context, 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context) =>
    Consumer<ForgotPasswordViewModel>(builder: (context, viewModel, _) {
  return SharedButton(
    color: UIHelper.black,
    title: "Reset Password",
    onPressed: viewModel.isResetButtonActive
        ? () async {
            try {
              await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: viewModel.emailController.text.trim());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset email sent successfully'),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to send password reset email: $e'),
                ),
              );
            }
          }
        : null,
  );
});

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
