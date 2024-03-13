import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/viewmodel/auth/code_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CodeView extends StatelessWidget {
  const CodeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CodeViewModel(),
      child: Consumer<CodeViewModel>(builder: (context, viewModel, _) {
        return Scaffold(
          appBar: const BackAppBar(),
          body: Padding(
            padding: UIHelper.pagePadding(context),
            child: Column(
              children: <Widget>[
                UIHelper.emptySpaceHeight(context, 0.02),
                _headlineText(context),
                UIHelper.emptySpaceHeight(context, 0.05),
                _otpField(context, viewModel),
                UIHelper.emptySpaceHeight(context, 0.03),
                _resendCode(context),
                UIHelper.emptySpaceHeight(context, 0.03),
                _contactUs(context),
                const Spacer(),
                _button(context),
                UIHelper.emptySpaceHeight(context, 0.04),
              ],
            ),
          ),
        );
      }),
    );
  }

  SharedButton _button(BuildContext context) => SharedButton(
        title: "Next",
        color: UIHelper.black,
        onPressed: () => context.router.push(const CongratsRoute()),
      );

  Widget _contactUs(BuildContext context) => RichText(
        text: TextSpan(
            text: "Didn't receive the code? ",
            style: TextStyle(
                color: UIHelper.formalGrey,
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
                fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text: "Contact us",
                style: TextStyle(
                  color: UIHelper.saltwaterDenim,
                  fontSize:
                      UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ]),
      );

  Widget _resendCode(BuildContext context) => GestureDetector(
        onTap: () => debugPrint("Resend Code"),
        child: Text(
          "Resend Code",
          style: TextStyle(
            color: UIHelper.saltwaterDenim,
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize14),
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _otpField(BuildContext context, CodeViewModel viewModel) =>
      PinCodeTextField(
        controller: viewModel.otpController,
        autoDismissKeyboard: true,
        autoFocus: true,
        autoUnfocus: true,
        focusNode: viewModel.otpFocusNode,
        textStyle: TextStyle(
          fontSize: UIHelper.getDynamicWidth(context, 0.05),
          color: viewModel.hasError ? UIHelper.tomatoFrog : UIHelper.black,
        ),
        pastedTextStyle: const TextStyle(
            color: UIHelper.saltwaterDenim, fontWeight: FontWeight.bold),
        appContext: context,
        length: 5,
        animationType: AnimationType.none,
        animationDuration: Duration.zero,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldHeight: UIHelper.getDynamicHeight(context, 0.07),
          fieldWidth: UIHelper.getDynamicWidth(context, 0.14),
          activeFillColor: UIHelper.plaster,
          inactiveFillColor: UIHelper.plaster,
          selectedFillColor: UIHelper.plaster,
          activeColor:
              viewModel.hasError ? UIHelper.tomatoFrog : UIHelper.black,
          inactiveColor:
              viewModel.hasError ? UIHelper.tomatoFrog : UIHelper.black,
          selectedColor:
              viewModel.hasError ? UIHelper.tomatoFrog : UIHelper.black,
          borderWidth: 1,
        ),
        cursorColor: UIHelper.saltwaterDenim,
        keyboardType: TextInputType.number,
        onChanged: (String? text) {
          if (text!.length <= 4) {
            viewModel.setIsButtonDisabled = true;
            viewModel.setHasError = false;
          } else {
            viewModel.otpFocusNode.unfocus();
            viewModel.setIsButtonDisabled = false;
            viewModel.setHasError = false;
          }
        },
        onTap: () {
          if (viewModel.otpController.text.isNotEmpty) {
            viewModel.otpController.clear();
          }
        },
      );

  Align _headlineText(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Enter the code\nyou recieved.",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
