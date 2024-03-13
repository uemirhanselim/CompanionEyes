import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/profile/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: Consumer<EditProfileViewModel>(builder: (context, viewModel, _) {
        return GestureDetector(
          onTap: () {
            viewModel.firstNameFocusNode.unfocus();
            viewModel.lastNameFocusNode.unfocus();
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
        title: "Update Profile",
        color: UIHelper.black,
        onPressed: () {},
      );

  Widget _textFields(BuildContext context, EditProfileViewModel viewModel) =>
      Column(
        children: <Widget>[
          SharedTextFormField(
              title: "First Name ",
              controller: viewModel.firstNameController,
              focusNode: viewModel.firstNameFocusNode),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
              title: "Last Name ",
              controller: viewModel.lastNameController,
              focusNode: viewModel.lastNameFocusNode),
        ],
      );

  Widget _headlineText(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
