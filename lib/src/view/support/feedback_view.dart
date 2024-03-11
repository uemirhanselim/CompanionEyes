import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/support/feedback_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedbackViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Padding(
          padding: UIHelper.pagePadding(context),
          child: Align(
            child: Column(
              children: <Widget>[
                _topPart(context),
                UIHelper.emptySpaceHeight(context, 0.02),

                _textFields,
                const Spacer(),
                _button,
                UIHelper.emptySpaceHeight(context, 0.02),
                // _body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SharedButton get _button => SharedButton(
        title: "Send",
        color: UIHelper.black,
        onPressed: () {},
      );

  Widget get _textFields =>
      Consumer<FeedbackViewModel>(builder: (context, viewModel, _) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SharedTextFormField(
                title: "Email",
                controller: viewModel.emailController,
                focusNode: viewModel.emailFocusNode,
              ),
              UIHelper.emptySpaceHeight(context, 0.02),
              SharedTextFormField(
                title: "Issue",
                controller: viewModel.issueController,
                focusNode: viewModel.issueFocusNode,
              ),
              UIHelper.emptySpaceHeight(context, 0.02),
              SharedTextFormField(
                title: "Description",
                controller: viewModel.descriptionController,
                focusNode: viewModel.descriptionFocusNode,
              ),
            ],
          ),
        );
      });

  Widget _topPart(BuildContext context) => Column(
        children: <Widget>[
          _appLogo,
          _headlineText(context),
        ],
      );

  Image get _appLogo => Image.asset(UIHelper.appLogoIcon);

  Widget _headlineText(BuildContext context) => Text(
        "Send us feedback",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          fontWeight: FontWeight.bold,
        ),
      );
}
