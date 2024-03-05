import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/auth/register_view.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_phone_number_text_field.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/auth/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIHelper.emptySpaceHeight(context, 0.02),
              _headlineText(context),
              UIHelper.emptySpaceHeight(context, 0.05),
              _fields(context),
              const Spacer(),
              _button,
              UIHelper.emptySpaceHeight(context, 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _button => SharedButton(
        color: UIHelper.black,
        title: "Next",
        onPressed: () {},
      );

  Widget _fields(BuildContext context) => Consumer<ForgotPasswordViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            children: <Widget>[
              SharedPhoneNumberTextField(
                focusNode: viewModel.phoneNumberFocusNode,
                onInputChanged: (p0) {},
              ),
              UIHelper.emptySpaceHeight(context, 0.02),
              SharedTextFormField(
                title: "New Password",
                controller: viewModel.newPasswordController,
                focusNode: viewModel.newPasswordFocusNode,
              ),
              UIHelper.emptySpaceHeight(context, 0.02),
              SharedTextFormField(
                title: "Confirm Password",
                controller: viewModel.confirmPasswordController,
                focusNode: viewModel.confirmPasswordFocusNode,
              ),
            ],
          );
        },
      );

  Text _headlineText(BuildContext context) => Text(
        "Enter your\nphone number.",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
