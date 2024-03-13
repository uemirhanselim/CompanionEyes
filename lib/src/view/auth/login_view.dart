import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_phone_number_text_field.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/auth/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return SingleChildScrollView(
              child: Align(
                child: Padding(
                  padding: UIHelper.pagePadding(context),
                  child: Column(
                    children: <Widget>[
                      UIHelper.emptySpaceHeight(context, 0.02),
                      _headlineText(context),
                      UIHelper.emptySpaceHeight(context, 0.05),
                      _fields(viewModel, context),
                      UIHelper.emptySpaceHeight(context, 0.06),
                      _buttons(context, viewModel),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Column _buttons(BuildContext context, LoginViewModel viewModel) => Column(
        children: [
          SharedButton(
            color: UIHelper.black,
            title: "Next",
            onPressed: viewModel.isNextButtonActive
                ? () => context.router.push(const HomeRoute())
                : null,
          ),
          UIHelper.emptySpaceHeight(context, 0.032),
          SharedButton(
            color: UIHelper.saltwaterDenim,
            title: "Forgot Password?",
            onPressed: () => context.router.push(const ForgotPasswordRoute()),
          ),
          UIHelper.emptySpaceHeight(context, 0.04),
        ],
      );

  Column _fields(LoginViewModel viewModel, BuildContext context) => Column(
        children: [
          SharedPhoneNumberTextField(
            focusNode: viewModel.phoneNumberFocusNode,
            onInputChanged: (PhoneNumber phoneNumber) {
              viewModel.phoneNumberController.text = phoneNumber.phoneNumber!;
            },
          ),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
            title: "Password",
            controller: viewModel.passwordController,
            focusNode: viewModel.passwordFocusNode,
          ),
        ],
      );

  Text _headlineText(BuildContext context) => Text(
        "Sign In",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
