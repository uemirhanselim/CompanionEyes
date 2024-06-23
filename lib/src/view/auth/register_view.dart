import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/auth/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RegisterView extends StatelessWidget {
  const RegisterView({super.key, required this.isVolunteer});
  final bool isVolunteer;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(isVolunteer: isVolunteer),
      child: Consumer<RegisterViewModel>(builder: (context, viewModel, _) {
        return GestureDetector(
          onTap: () => viewModel.unFocusFields(),
          child: Scaffold(
            appBar: const BackAppBar(),
            body: SingleChildScrollView(
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
            ),
          ),
        );
      }),
    );
  }

  Column _buttons(BuildContext context, RegisterViewModel viewModel) => Column(
        children: [
          SharedButton(
            color: UIHelper.black,
            title: "Next",
            onPressed: viewModel.isNextButtonActive
                ? () async => await viewModel.createAccount(context)
                : null,
            isLoading: viewModel.isLoading,
          ),
          UIHelper.emptySpaceHeight(context, 0.01),
          _alreadyAUser(context),
          UIHelper.emptySpaceHeight(context, 0.01),
          SharedButton(
            color: UIHelper.saltwaterDenim,
            title: "Sign in",
            onPressed: () => context.router.push(const LoginRoute()),
          ),
          UIHelper.emptySpaceHeight(context, 0.04),
        ],
      );

  Text _alreadyAUser(BuildContext context) => Text(
        "Already a user?",
        style: TextStyle(
            shadows: const [
              Shadow(
                color: UIHelper.formalGrey,
                blurRadius: 20,
              ),
            ],
            fontWeight: FontWeight.w500,
            fontSize: UIHelper.getDynamicFontSize(
              context,
              UIHelper.fontSize16,
            )),
      );

  Column _fields(RegisterViewModel viewModel, BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SharedTextFormField(
                title: "First Name",
                controller: viewModel.firstNameController,
                focusNode: viewModel.firstNameFocusNode,
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    viewModel.setIsFirstNameEntered = true;
                  } else {
                    viewModel.setIsFirstNameEntered = false;
                  }
                },
              ),
              SharedTextFormField(
                title: "Last Name",
                controller: viewModel.lastNameController,
                focusNode: viewModel.lastNameFocusNode,
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    viewModel.setIsLastNameEntered = true;
                  } else {
                    viewModel.setIsLastNameEntered = false;
                  }
                },
              ),
            ],
          ),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
            title: "Email",
            controller: viewModel.emailController,
            focusNode: viewModel.emailFocusNode,
            onChanged: (text) {
              if (text.isNotEmpty) {
                viewModel.setIsEmailEntered = true;
              } else {
                viewModel.setIsEmailEntered = false;
              }
            },
          ),
          UIHelper.emptySpaceHeight(context, 0.02),
          _dropDownField(context, viewModel, "Gender"),
          UIHelper.emptySpaceHeight(context, 0.02),
          _dropDownField(context, viewModel, "Language"),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
            title: "Password",
            controller: viewModel.passwordController,
            focusNode: viewModel.passwordFocusNode,
            onChanged: (text) {
              if (text.isNotEmpty) {
                viewModel.setIsPasswordEntered = true;
              } else {
                viewModel.setIsPasswordEntered = false;
              }
            },
          ),
        ],
      );

  Widget _dropDownField(
          BuildContext context, RegisterViewModel viewModel, String title) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize:
                  UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
              color: UIHelper.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          UIHelper.emptySpaceHeight(context, 0.005),
          CustomDropdown(
            closedHeaderPadding:
                EdgeInsets.all(UIHelper.getDynamicHeight(context, 0.016)),
            expandedHeaderPadding:
                EdgeInsets.all(UIHelper.getDynamicHeight(context, 0.016)),
            decoration: CustomDropdownDecoration(
              hintStyle: TextStyle(
                fontSize:
                    UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
                color: UIHelper.formalGrey,
                fontWeight: FontWeight.w600,
              ),
              closedFillColor: UIHelper.plaster,
              expandedFillColor: UIHelper.plaster,
              listItemStyle: const TextStyle(
                color: UIHelper.black,
              ),
            ),
            items: title == "Gender" ? viewModel.genders : viewModel.languages,
            onChanged: (String? text) {
              if (title == "Gender") {
                viewModel.setSelectedGender = text;
              } else if (title == "Language") {
                viewModel.setSelectedLanguage = text;
              }
            },
          ),
        ],
      );

  Text _headlineText(BuildContext context) => Text(
        "Sign Up",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
