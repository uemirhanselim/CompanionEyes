import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/routes/app_router.dart';
import 'package:companioneyes/src/utils/ui_helper.dart';
import 'package:companioneyes/src/view/widgets/back_app_bar.dart';
import 'package:companioneyes/src/view/widgets/shared_button.dart';
import 'package:companioneyes/src/view/widgets/shared_phone_number_text_field.dart';
import 'package:companioneyes/src/view/widgets/shared_text_form_field.dart';
import 'package:companioneyes/src/viewmodel/auth/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

@RoutePage()
class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
        appBar: const BackAppBar(),
        body: Consumer<RegisterViewModel>(builder: (context, viewModel, _) {
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
          }),
      ),
    );
  }

  Column _buttons(BuildContext context, RegisterViewModel viewModel) => Column(
        children: [
          SharedButton(
            color: UIHelper.black,
            title: "Next",
            onPressed: () async {
              if (viewModel.isNextButtonActive) {
                try {
                  UserCredential userCredential = await FirebaseAuth
                      .instance
                      .createUserWithEmailAndPassword(
                    email: viewModel.emailController.text.trim(),
                    password: viewModel.passwordController.text,
                  );
                  await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
                    'firstName': viewModel.firstNameController.text,
                    'lastName': viewModel.lastNameController.text,
                    'email': viewModel.emailController.text.trim(),
                    'gender': viewModel.selectedGender,
                    'language': viewModel.selectedLanguage,
                  });
                  context.router.push(const PrivacyAndTermsRoute());
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Registration failed: $e")),
                  );
                }
              }
            },
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
              ),
              SharedTextFormField(
                title: "Last Name",
                controller: viewModel.lastNameController,
                focusNode: viewModel.lastNameFocusNode,
              ),
            ],
          ),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
            title: "Email",
            controller: viewModel.emailController,
            focusNode: viewModel.emailFocusNode),
          UIHelper.emptySpaceHeight(context, 0.02),
          _dropDownField(context, viewModel, "Gender"),
          UIHelper.emptySpaceHeight(context, 0.02),
          _dropDownField(context, viewModel, "Language"),
          UIHelper.emptySpaceHeight(context, 0.02),
          SharedTextFormField(
            title: "Password",
            controller: viewModel.passwordController,
            focusNode: viewModel.passwordFocusNode,
          ),
        ],
      );

  Column _dropDownField( 
      BuildContext context, RegisterViewModel viewModel, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize12),
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
          onChanged: (String text) {
            if (title == "Gender") {
              viewModel.setSelectedGender(text);
            } else if (title == "Language") {
              viewModel.setSelectedLanguage(text);
            }
          },
        ),
      ],
    );
  }

  Text _headlineText(BuildContext context) => Text(
        "Sign Up",
        style: TextStyle(
          fontSize: UIHelper.getDynamicFontSize(context, UIHelper.fontSize32),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
